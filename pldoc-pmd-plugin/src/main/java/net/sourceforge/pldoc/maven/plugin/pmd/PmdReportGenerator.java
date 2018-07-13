//package org.apache.maven.plugin.pmd;
package net.sourceforge.pldoc.maven.plugin.pmd;

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import net.sourceforge.pmd.RuleViolation;
import net.sourceforge.pmd.stat.Metric;
import org.apache.maven.doxia.sink.Sink;
import org.apache.maven.plugin.logging.Log;
import org.codehaus.plexus.util.StringUtils;

/**
 * Render the PMD violations into Doxia events.
 *
 * @author Brett Porter
 * @version $Id$
 */
public class PmdReportGenerator
{
     /** Default filename search pattern - map FileInfo to xref filename */
    private static final String DEFAULT_SEARCH_PATTERN = "\\.java$";
    
    /** Default filename replacement pattern -  */
    private static final String DEFAULT_REPLACE_PATTERN = ".html";

  
    private Log log;

    private Sink sink;

    private String currentFilename;

    private ResourceBundle bundle;

    private HashSet<RuleViolation> violations = new HashSet<RuleViolation>();

    private boolean aggregate;

    // The number of erroneous files
    private int fileCount = 0;

    private Map<File, PmdFileInfo> files;
    
    /** filename search pattern - map FileInfo to xref filename */
    private String searchPattern = DEFAULT_SEARCH_PATTERN;
    
    /** filename replacement pattern -  */
    private String replacePattern = DEFAULT_REPLACE_PATTERN;

    private List<Metric> metrics = new ArrayList<Metric>();

    public PmdReportGenerator( Log log, Sink sink, ResourceBundle bundle, boolean aggregate 
            , String searchPattern
            , String replacePattern
    )
    {
        this.log = log;
        this.sink = sink;
        this.bundle = bundle;
        this.aggregate = aggregate;
 
        if (null!= searchPattern)
        {
          this.searchPattern = searchPattern ;
        }

        if (null!= replacePattern)
        {
          this.replacePattern = replacePattern ;
        }
    }

    public PmdReportGenerator( Log log, Sink sink, ResourceBundle bundle, boolean aggregate )
    {
     this ( log,  sink,  bundle,  aggregate , DEFAULT_SEARCH_PATTERN , DEFAULT_REPLACE_PATTERN) ;
    }

    private String getTitle()
    {
        return bundle.getString( "report.pmd.title" );
    }

    public void setViolations( Collection<RuleViolation> violations )
    {
        this.violations = new HashSet<RuleViolation>( violations );
    }

    public List<RuleViolation> getViolations()
    {
        return new ArrayList<RuleViolation>( violations );
    }

    public List<Metric> getMetrics()
    {
        return metrics;
    }

    public void setMetrics( List<Metric> metrics )
    {
        this.metrics = metrics;
    }

    private void startFileSection( String currentFilename, PmdFileInfo fileInfo )
    {
        sink.section2();
        sink.sectionTitle2();

        // prepare the filename
        this.currentFilename = currentFilename;
        log.debug("startFileSection currentFilename set from parameter:"+currentFilename);
        if ( fileInfo != null && fileInfo.getSourceDirectory() != null )
        {
            /*
            * Under Windows, File ("/Database").getAbsolutePath() is returned as ${PWD}/Database, where File ("/Database/path").getAbsolutePath() comes back as expected.
            * This means that the relative path from the "/Database" SourceDirectory to the "/Database/schema/object-type/object-name.suffix" path
            * is generated incorrectly.
            *
            * The ternary operator below is an explicit, undesirable workaround for this problem.
            */


          this.currentFilename =
                StringUtils.substring( currentFilename
                                         , currentFilename.startsWith(AbstractPmdReport.DEFAULT_SOURCE_ROOT)
                                           ? AbstractPmdReport.DEFAULT_SOURCE_ROOT.length() + 1 
                                           : fileInfo.getSourceDirectory().getAbsolutePath().length() + 1   
                                       );
          log.debug("startFileSection currentFilename set from parameter:"+currentFilename 
                  + " and fileInfo.sourceDirectory:" + fileInfo.getSourceDirectory().getAbsolutePath()
           );
        }
        this.currentFilename = StringUtils.replace( this.currentFilename, "\\", "/" );
        log.debug("startFileSection this.currentFilename :"+this.currentFilename);

        String title = this.currentFilename;
        if ( aggregate && fileInfo != null && fileInfo.getProject() != null )
        {
            title = fileInfo.getProject().getName() + " - " + this.currentFilename;
        }
        sink.text( title );
        sink.sectionTitle2_();

        sink.table();
        sink.tableRow();
        sink.tableHeaderCell();
        sink.text( bundle.getString( "report.pmd.column.violation" ) );
        sink.tableHeaderCell_();
        sink.tableHeaderCell();
        sink.text( bundle.getString( "report.pmd.column.line" ) );
        sink.tableHeaderCell_();
        sink.tableRow_();
    }

    private void endFileSection()
    {
        sink.table_();
        sink.section2_();
    }

    private void processSingleRuleViolation( RuleViolation ruleViolation, PmdFileInfo fileInfo )
    {
        sink.tableRow();
        sink.tableCell();
        sink.text( ruleViolation.getDescription() );
        sink.tableCell_();
        sink.tableCell();

        int beginLine = ruleViolation.getBeginLine();
        outputLineLink( beginLine, fileInfo );
        int endLine = ruleViolation.getEndLine();
        if ( endLine != beginLine )
        {
            sink.text( "&#x2013;" );
            outputLineLink( endLine, fileInfo );
        }

        sink.tableCell_();
        sink.tableRow_();
    }

    // PMD might run the analysis multi-threaded, so the violations might be reported
    // out of order. We sort them here by filename and line number before writing them to
    // the report.
    private void processViolations()
        throws IOException
    {
        fileCount = files.size();
        ArrayList<RuleViolation> violations2 = new ArrayList<RuleViolation>( violations );
        Collections.sort( violations2, new Comparator<RuleViolation>()
        {
            /** {@inheritDoc} */
            public int compare( RuleViolation o1, RuleViolation o2 )
            {
                int filenames = o1.getFilename().compareTo( o2.getFilename() );
                if ( filenames == 0 )
                {
                    return o1.getBeginLine() - o2.getBeginLine();
                }
                else
                {
                    return filenames;
                }
            }
        } );

        boolean fileSectionStarted = false;
        String previousFilename = null;
        for ( RuleViolation ruleViolation : violations2 )
        {
            String currentFn = ruleViolation.getFilename();
            File  file  = new File( currentFn ) ;
            File canonicalFilename = file.getCanonicalFile();
            log.debug("processViolations RuleViolation.getFilename(): "+currentFn);
            PmdFileInfo fileInfo = files.get( currentFn.startsWith(AbstractPmdReport.DEFAULT_SOURCE_ROOT)
                                                ?  file
                                                :  canonicalFilename
                                             );
            if ( fileInfo == null )
            {
                log.warn( "Couldn't determine PmdFileInfo for file " + currentFn 
                            + " (abstract file: " + file
                            + " , canonical: " + canonicalFilename
                            + "). XRef links won't be available." );
            }

            if ( !currentFn.equalsIgnoreCase( previousFilename ) && fileSectionStarted )
            {
                endFileSection();
                fileSectionStarted = false;
            }
            if ( !fileSectionStarted )
            {
                startFileSection( currentFn, fileInfo );
                fileSectionStarted = true;
            }

            processSingleRuleViolation( ruleViolation, fileInfo );

            previousFilename = currentFn;
        }

        if ( fileSectionStarted )
        {
            endFileSection();
        }
    }

    private void outputLineLink( int line, PmdFileInfo fileInfo )
    {
        String xrefLocation = null;
        if ( fileInfo != null )
        {
            xrefLocation = fileInfo.getXrefLocation();
        }

        if ( xrefLocation != null )
        {
            //@TODO mapping depends on language - java replace with html; plsql append .xml 
            log.debug("PmdGenerator: currentFilename=="+currentFilename);
            log.debug("PmdGenerator: searchPattern=="+searchPattern);
            log.debug("PmdGenerator: replacePattern=="+replacePattern);
	    //
	    //URIEncode any unsafe characters in the filename
	    try
	    {
		    URI uri = new URI( "file" , "localhost", null,  currentFilename );
		    currentFilename = uri.getRawFragment();
	    }
	    catch (URISyntaxException ex)
	    {
		    //Ignore syntax problems: we are no worse off than before we tried to make filename URI safe
	    }
            log.debug("PmdGenerator: encoded currentFilename=="+currentFilename);

            sink.link( 
			/* Transformations 
			 * ---------------
			 *
			 * xrefLocation - 
			 *
			 * filename - is actually a file path: Package and Object Type Specifications are generated under folder path 
			 *                                     (PACKAGE|TYPE)_SPEC, but PLDoc extracts source under (PACKAGE|TYPE):  
			 *                                     convert filename to correct folder location 
			 *            generate the correct file suffix
			 *            convert Windows folder separators to Unix/ HTML folder separators 
			 *
			 * .replaceAll("_SPEC([/\\][^/\\]*)$" , "${2}")
			 */
			xrefLocation + "/" + currentFilename.replaceAll(searchPattern, replacePattern ).replace( '\\', '/' ).replaceAll("_SPEC/","/") + "#L" + line
		    );
        }
        sink.text( String.valueOf( line ) );
        if ( xrefLocation != null )
        {
            sink.link_();
        }
    }

    public void beginDocument()
    {
        sink.head();
        sink.title();
        sink.text( getTitle() );
        sink.title_();
        sink.head_();

        sink.body();

        sink.section1();
        sink.sectionTitle1();
        sink.text( getTitle() );
        sink.sectionTitle1_();

        sink.paragraph();
        sink.text( bundle.getString( "report.pmd.pmdlink" ) + " " );
        sink.link( "http://pmd.sourceforge.net/" );
        sink.text( "PMD" );
        sink.link_();
        sink.text( " " + AbstractPmdReport.getPmdVersion() + "." );
        sink.paragraph_();

        sink.section1_();

        // TODO overall summary

        sink.section1();
        sink.sectionTitle1();
        sink.text( bundle.getString( "report.pmd.files" ) );
        sink.sectionTitle1_();

        // TODO files summary
    }

    /**
     * @return a Map summarizing the Metrics: String (rule name) -> Metric (aggregate iof metrics)
     */
    private Collection<Metric> getMetricsSummary() {
        //SRT System.err.println("getMetricsSummary: metrics="+metrics.size());
        Map<String, Metric> summary = new HashMap<String, Metric>();
        for (Metric m : metrics) {
            String name = m.getMetricName();
            if (!summary.containsKey(name)) {
                summary.put(name, new Metric(name, m.getCount(), m.getTotal(),m.getLowValue(), m.getHighValue(),m.getAverage(), -1.0) );
            }
	    else
            {
	      Metric runningAggregate = summary.get(name);
              // Metric has no setters and all fields are private, so must create a new object 
	      Metric metric = new Metric ( 
					   name
					   ,m.getCount()+runningAggregate.getCount()
					   ,m.getTotal()+runningAggregate.getTotal()
					   ,-1 == runningAggregate.getLowValue() || m.getLowValue() < runningAggregate.getLowValue()
					      ? m.getLowValue() : runningAggregate.getLowValue()
					   ,m.getHighValue() > runningAggregate.getHighValue()
					      ? m.getHighValue() : runningAggregate.getHighValue()
					   ,( m.getAverage()+runningAggregate.getAverage() ) / 2.0 
					   ,-1.0 
					); 
	      summary.put(name, metric);
            }
        }
        //SRT System.err.println("getMetricsSummary: summary="+summary.values().size());
        return summary.values() ;
	/*
        return Collections.sort(
			       summary.values()
			       , new Comparator<Metric>() 
				   {
				    public int compare(Metric m1, Metric m2) 
				    {
				      return m1.getMetricName().compareTo(m2.getMetricName());
				    }
				   }    
			      );
	*/
    }


    private void processMetrics()
    {
        if ( metrics.size() == 0 )
        {
            return;
        }

        sink.section1();
        sink.sectionTitle1();
        sink.text( "Metrics Summary" );
        sink.sectionTitle1_();

        sink.table();
        sink.tableRow();
        sink.tableHeaderCell();
        sink.text( "Name" );
        sink.tableHeaderCell_();
        sink.tableHeaderCell();
        sink.text( "Count" );
        sink.tableHeaderCell_();
        sink.tableHeaderCell();
        sink.text( "High" );
        sink.tableHeaderCell_();
        sink.tableHeaderCell();
        sink.text( "Low" );
        sink.tableHeaderCell_();
        sink.tableHeaderCell();
        sink.text( "Average" );
        sink.tableHeaderCell_();
        sink.tableRow_();

        for ( Metric met : getMetricsSummary() /* metrics */  )
        {
            sink.tableRow();
            sink.tableCell();
            sink.text( met.getMetricName() );
            sink.tableCell_();
            sink.tableCell();
            sink.text( String.valueOf( met.getCount() ) );
            sink.tableCell_();
            sink.tableCell();
            sink.text( String.valueOf( met.getHighValue() ) );
            sink.tableCell_();
            sink.tableCell();
            sink.text( String.valueOf( met.getLowValue() ) );
            sink.tableCell_();
            sink.tableCell();
            sink.text( String.valueOf( met.getAverage() ) );
            sink.tableCell_();
            sink.tableRow_();
        }
        sink.table_();
        sink.section1_();
    }


    public void render()
        throws IOException
    {
        processViolations();
    }

    public void endDocument()
        throws IOException
    {
        if ( fileCount == 0 )
        {
            sink.paragraph();
            sink.text( bundle.getString( "report.pmd.noProblems" ) );
            sink.paragraph_();
        }

        sink.section1_();

        // The Metrics report useless with the current PMD metrics impl.
        // For instance, run the coupling ruleset and you will get a boatload
        // of excessive imports metrics, none of which is really any use.
        // TODO Determine if we are going to just ignore metrics.

        processMetrics();

        sink.body_();

        sink.flush();

        sink.close();
    }

    public void setFiles( Map<File, PmdFileInfo> files )
    {
        this.files = files;
    }
}
