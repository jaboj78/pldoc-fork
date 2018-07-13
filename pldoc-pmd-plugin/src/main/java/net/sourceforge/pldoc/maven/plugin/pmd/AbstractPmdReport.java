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
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import net.sourceforge.pmd.PMD;
import net.sourceforge.pmd.lang.Language;
import net.sourceforge.pmd.lang.LanguageRegistry;
import org.apache.maven.doxia.siterenderer.Renderer;
import org.apache.maven.model.ConfigurationContainer;
import org.apache.maven.model.Plugin;
import org.apache.maven.model.PluginExecution;
import org.apache.maven.model.Reporting;
import org.apache.maven.model.ReportPlugin;
import org.apache.maven.plugins.annotations.Component;
import org.apache.maven.plugins.annotations.Parameter;
import org.apache.maven.project.MavenProject;
import org.apache.maven.reporting.AbstractMavenReport;
import org.codehaus.plexus.util.FileUtils;
import org.codehaus.plexus.util.PathTool;
import org.codehaus.plexus.util.ReaderFactory;
import org.codehaus.plexus.util.StringUtils;
import org.codehaus.plexus.util.xml.Xpp3Dom;


/**
 * Base class for the PMD reports.
 *
 * @author <a href="mailto:brett@apache.org">Brett Porter</a>
 * @version $Id$
 */
public abstract class AbstractPmdReport
    extends AbstractMavenReport
{
    /**
     *  Notional source root of database objects 
     */
    
    public static final String DEFAULT_SOURCE_ROOT = "/Database" ;

    /**
     * The output directory for the intermediate XML report.
     */
    @Parameter( property = "project.build.directory", required = true )
    protected File targetDirectory;

    /**
     * The output directory for the final HTML report. Note that this parameter is only evaluated if the goal is run
     * directly from the command line or during the default lifecycle. If the goal is run indirectly as part of a site
     * generation, the output directory configured in the Maven Site Plugin is used instead.
     */
    @Parameter( property = "project.reporting.outputDirectory", required = true )
    protected File outputDirectory;

    /**
     * Site rendering component for generating the HTML report.
     */
    @Component
    private Renderer siteRenderer;

    /**
     * The project to analyse.
     */
    @Component
    protected MavenProject project;

    /**
     * Set the output format type, in addition to the HTML report.  Must be one of: "none",
     * "csv", "xml", "txt" or the full class name of the PMD renderer to use.
     * See the net.sourceforge.pmd.renderers package javadoc for available renderers.
     * XML is required if the pmd:check goal is being used.
     */
    @Parameter( property = "format", defaultValue = "xml" )
    protected String format = "xml";

    /**
     * Link the violation line numbers to the source xref. Links will be created
     * automatically if the jxr plugin is being used.
     */
    @Parameter( property = "linkXRef", defaultValue = "true" )
    private boolean linkXRef;

    /**
     * Location of the Xrefs to link to.
     */
    @Parameter( defaultValue = "${project.reporting.outputDirectory}/xref" )
    private File xrefLocation;

    /**
     * Location of the Test Xrefs to link to.
     */
    @Parameter( defaultValue = "${project.reporting.outputDirectory}/xref-test" )
    private File xrefTestLocation;

    /**
     * A list of files to exclude from checking. Can contain Ant-style wildcards and double wildcards. Note that these
     * exclusion patterns only operate on the path of a source file relative to its source root directory. In other
     * words, files are excluded based on their package and/or class name. If you want to exclude entire source root
     * directories, use the parameter <code>excludeRoots</code> instead.
     *
     * @since 2.2
     */
    @Parameter
    private List<String> excludes;

    /**
     * A list of files to include from checking. Can contain Ant-style wildcards and double wildcards.
     * Defaults to **\/*.java.
     *
     * @since 2.2
     */
    @Parameter
    protected List<String> includes;

    /**
     * The directories containing the sources to be compiled.
     * <p>Defaults to {@link project.compileSourceRoots}.
     * </p>
     */
    @Parameter( property = "project.compileSourceRoots", required = true, readonly = true )
    private List<String> compileSourceRoots;

    /**
     * The directories containing the sources to be interpreted.
     * <p>Defaults to {@link project.scriptSourceRoots}.
     * </p>
     *
     * @since 3.0.2
     */
    @Parameter
    private List<String> scriptSourceRoots;

    /**
     * The directories containing the test-sources to be compiled.
     */
    @Parameter( property = "project.testCompileSourceRoots", required = true, readonly = true )
    private List<String> testSourceRoots;

    /**
     * The project source directories that should be excluded.
     *
     * @since 2.2
     */
    @Parameter
    private File[] excludeRoots;

    /**
     * Run PMD on the tests.
     *
     * @since 2.2
     */
    @Parameter( defaultValue = "false" )
    protected boolean includeTests;

    /**
     * Whether to build an aggregated report at the root, or build individual reports.
     *
     * @since 2.2
     */
    @Parameter( property = "aggregate", defaultValue = "false" )
    protected boolean aggregate;

    /**
     * The file encoding to use when reading the Java sources.
     *
     * @since 2.3
     */
    @Parameter( property = "encoding", defaultValue = "${project.build.sourceEncoding}" )
    private String sourceEncoding;

    /**
     * The file encoding when writing non-HTML reports.
     *
     * @since 2.5
     */
    @Parameter( property = "outputEncoding", defaultValue = "${project.reporting.outputEncoding}" )
    private String outputEncoding;

    /**
     * The projects in the reactor for aggregation report.
     */
    @Parameter( property = "reactorProjects", readonly = true )
    protected List<MavenProject> reactorProjects;

    /**
     * Whether to include the xml files generated by PMD/CPD in the site.<br/>
     * <strong>Note:</strong> In versions 2.2 - 2.7.1 the default value for this
     * was <code>true</code>. This was changed in version 3.0.
     *
     * @since 3.0
     */
    @Parameter( defaultValue = "false" )
    protected boolean includeXmlInSite;

    /**
     * Skip the PMD/CPD report generation if there are no violations or duplications found.
     * Defaults to <code>true</code>.
     *
     * @since 3.1
     */
    @Parameter( defaultValue = "true" )
    protected boolean skipEmptyReport;

    /** Source language that will be analysed.
     *
     *<p>This value cannot be pulled up from the subtypes because the subtypes default values are derived from different property values.
     *</p>
     * 
     */
    protected String sourceLanguage = "java";
    
    /** The files that are being analysed. */
    protected Map<File, PmdFileInfo> filesToProcess;

    /**
     * {@inheritDoc}
     */
    protected MavenProject getProject()
    {
        return project;
    }

    /**
     * {@inheritDoc}
     */
    protected Renderer getSiteRenderer()
    {
        return siteRenderer;
    }

    protected String constructXRefLocation( boolean test )
    {
        String location = null;
        if ( linkXRef )
        {
            File xrefLoc = test ? xrefTestLocation : xrefLocation;
            getLog().debug( "constructXRefLocation: Attempting to locate Source XRef location " );
            getLog().debug( "constructXRefLocation: xrefTestLocation " + xrefTestLocation);
            getLog().debug( "constructXRefLocation: xrefLocation " + xrefLocation );
            getLog().debug( "constructXRefLocation: outputDirectory="+ outputDirectory );
	    File projectReportingOutputDirectory = null ;
	    Reporting projectReporting = project.getReporting();
	    getLog().debug( "constructXRefLocation: (PLDoc) project.getReporting()="+projectReporting);
	    if(null!= projectReporting)
	    {
	      getLog().debug( "constructXRefLocation: project.getReporting().getOutputDirectory()="+projectReporting.getOutputDirectory());
	      projectReportingOutputDirectory = new File( projectReporting.getOutputDirectory() ) ;
	    }

            String relativePath =
                PathTool.getRelativePath( outputDirectory.getAbsolutePath(), xrefLoc.getAbsolutePath() );

            getLog().debug( "constructXRefLocation: relativePath="+ relativePath );
            
            if ( StringUtils.isEmpty( relativePath ) )
            {
                relativePath = ".";
                getLog().debug( "constructXRefLocation: relativePath="+ relativePath );
            }
            relativePath = relativePath + "/" + xrefLoc.getName();
            getLog().debug( "constructXRefLocation: relativePath="+ relativePath );
            if ( xrefLoc.exists() )
            {
                getLog().debug( "constructXRefLocation: xrefLoc exists" );
                // XRef was already generated by manual execution of a lifecycle binding
                location = relativePath;
                getLog().debug( "constructXRefLocation: location taken from relativePath="+ relativePath );
            }
            else
            {
                getLog().debug( "project.: xref is not yet generated =" );
                getLog().debug( "constructXRefLocation: xref is not yet generated =" );
                // Not yet generated - check if the report is on its way
                @SuppressWarnings( "unchecked" ) 
                //Check Configuration of "Classiic Configuration" Site reports, i.e 
                //plugins are configured within the project level <reports> tags
                List<ReportPlugin> reportPlugins = project.getReportPlugins();
                getLog().debug( "getReportPlugins() ..." );
                for ( ReportPlugin plugin : reportPlugins )
                {
                    String artifactId = plugin.getArtifactId();
                    getLog().debug( "constructXRefLocation: artifactId="+ artifactId );
                }
                for ( ReportPlugin plugin : reportPlugins )
                {
                    String artifactId = plugin.getArtifactId();
                    getLog().debug( "constructXRefLocation: artifactId="+ artifactId );

                    //Cope with java 
                    if ("java".equalsIgnoreCase(sourceLanguage) && 
                             ("maven-jxr-plugin".equals( artifactId ) || "jxr-maven-plugin".equals( artifactId ) )
                            )
                    {
                        getLog().debug( "Attempting to locate Source XRef for JXR plugins " );
			List<String> settings = getConfiguration("language",  plugin ) ;
			if (null == settings)
			{
			  location = relativePath;
			}
			else 
			{
			  for (String setting : settings )
			  {
			    if ("java".equalsIgnoreCase(setting) )
			    {
			      location = relativePath;
			    }
			  }
			}
                    }

                    if ( "plsql".equalsIgnoreCase(sourceLanguage) && 
                        (
                        "maven-pldoc-plugin".equals( artifactId ) || "pldoc-maven-plugin".equals( artifactId ) 
		        || "maven-cpd-plugin".equals( artifactId ) || "pldoc-cpd-plugin".equals( artifactId ) 
                         )
		       )
                    {
                        getLog().debug( "Attempting to locate Source XRef for PLdoc plugins " );
		        // Output location of PLDoc and any scraped code 

                        List<String> reportOutputDirs = getConfiguration("reportOutputDirectory", plugin ) ;
                        getLog().debug( "PLDoc reportOutputDirs " 
                                        + ( (null == reportOutputDirs) ? " not found " : " has " + reportOutputDirs.size() + " paths" ) 
                                );

                        List<String> destDirs = getConfiguration("destDir", plugin ) ;
                        getLog().debug( "PLDoc destDirs " 
                                        + ( (null == destDirs) ? " not found " : " has " + destDirs.size() + " paths" ) 
                                );
			File reportOutputDirectory = projectReportingOutputDirectory;

			if(null != reportOutputDirs )
			{
			  for (String setting : reportOutputDirs )
			  {
			      reportOutputDirectory = new File(setting) ;
			  }
			}

                        
			// Will any source code be saved 
			List<String> settings = getConfiguration("savesourcecode", plugin ) ;
                        getLog().debug( "Attempting to locate Source XRef for pldoc plugins " );

			//PLDoc Root 
			File pldocRoot = null ; 
			for (String setting : destDirs )
			{
                            if ( ( reportOutputDirectory != null ) 
                                 && ( setting != null ) 
                                 && ( !reportOutputDirectory.getAbsolutePath().endsWith( setting ) ) 
                               )
                            {
                                pldocRoot = new File( reportOutputDirectory, setting );
                            }
                            else
                            {
                                pldocRoot = reportOutputDirectory;
                            }
			}
                        getLog().debug( "pldocRoot value is \""+ pldocRoot+ "\""   );

			// Relative path to PLDoc Root 
                        getLog().debug( "outputDirectory Absolute Path is \""+ outputDirectory.getAbsolutePath()+ "\"");
                        getLog().debug( "pldocRoot Absolute Path is \""+ pldocRoot.getAbsolutePath()+ "\"");
			String pldocRootPath =
			    PathTool.getRelativeFilePath( outputDirectory.getAbsolutePath(), pldocRoot.getAbsolutePath() );
                        getLog().debug( "pldocRootPath value is \""+ pldocRootPath+ "\"");

			for (String setting : settings )
			{
                          getLog().debug( "savesourcecode value is \""+ setting+ "\"");
			  //Source Code will be or has been scraped
			  if ("true".equalsIgnoreCase(setting) )
			  {
			    location = pldocRootPath;
                            getLog().debug( "location set to pldocPath  \""+ pldocRootPath+ "\"");
			  }
			}
                    } //plsql 
                    
                }
                
                //Check for "New Configuration" Site reports, i.e. plugins
                //are configured within maven-site-plugins <reportPlugins> tags
                getLog().debug( "getBuildPlugins() ..." );
                List<Plugin> plugins = project.getBuildPlugins();
                //project.getReportConfiguration(location, relativePath, format)
                for ( Plugin plugin : plugins )
                //for ( Plugin plugin : plugins )
                {
                    String artifactId = plugin.getArtifactId();
                    getLog().debug( "constructXRefLocation: artifactId="+ artifactId );

                    //Cope with Maven 3 "New Configuration" plugins
                    if ( "maven-site-plugin".equals( artifactId ) )
                    {
                        getLog().debug( "Attempting to locate Executions ");
			List<PluginExecution> pluginExecutions =  plugin.getExecutions()  ;
                        for (PluginExecution pluginExecution : pluginExecutions )
                        {
                              getLog().debug( "PluginExecution is " + pluginExecution.getId() );
                              //@TODO - search for pldoc and pmd plugin execution configurd with language = plsql  
                              //jxr 
                        }
                        
                        //search through site plugin configuration for pldoc/javadoc 
                        getLog().debug( "New Configuration plugin search ... " );
                         Xpp3Dom configuration = (Xpp3Dom) plugin.getConfiguration();
                         Xpp3Dom reportOutputDirectorySetting = configuration.getChild( "reportOutputDirectory");
                         String newReportOutputDirectory = null;
                         if (null != reportOutputDirectorySetting)
                         {
                          newReportOutputDirectory = reportOutputDirectorySetting.getValue();
                          getLog().debug( "New Configuration plugin newReportOutputDirectory="+ newReportOutputDirectory );
                          Xpp3Dom newReportPlugins = configuration.getChild( "reportPlugins" );
                          getLog().debug( "New Configuration plugin ReportPlugins="+ newReportPlugins );
                          if (null!=newReportPlugins)
                          {
                            Xpp3Dom[] sitePlugins = newReportPlugins.getChildren( "plugin" );
                            if (null!= sitePlugins)
                            {
                            getLog().debug( "New Configuration there are sitePlugins " + sitePlugins.length);
                            for (Xpp3Dom sitePlugin : sitePlugins) 
                             {
                               String siteArtifactId = sitePlugin.getChild("artifactId").getValue();
                               getLog().debug( "New Configuration sitePlugin " + siteArtifactId);

                              //Cope with java 
                              if ("java".equalsIgnoreCase(sourceLanguage) && 
                                       ("maven-jxr-plugin".equals(siteArtifactId ) || "jxr-maven-plugin".equals( siteArtifactId ) )
                                      )
                              {
                                  getLog().debug( "NewConfig- Attempting to locate Source XRef for JXR plugins " );
                                  List<String> settings = getConfiguration("language",  sitePlugin ) ;
                                  if (null == settings)
                                  {
                                    location = relativePath;
                                  }
                                  else 
                                  {
                                    for (String setting : settings )
                                    {
                                      if ("java".equalsIgnoreCase(setting) )
                                      {
                                        location = relativePath;
                                      }
                                    }
                                  }
                              }
                              
                              if ( "plsql".equalsIgnoreCase(sourceLanguage) && 
                                  (
                                  "maven-pldoc-plugin".equals( siteArtifactId ) || "pldoc-maven-plugin".equals( siteArtifactId ) 
                                  || "maven-cpd-plugin".equals( siteArtifactId ) || "pldoc-cpd-plugin".equals( siteArtifactId ) 
                                   )
                                 )
                              {
                                  getLog().debug( "NewConfig- Attempting to locate Source XRef for PLDoc site plugins " );
                                  // Output location of PLDoc and any scraped code 

                                  List<String> reportOutputDirs = getConfiguration("reportOutputDirectory", sitePlugin ) ;
                                  getLog().debug( "NewConfig- PLDoc reportOutputDirs " 
                                                  + ( (null == reportOutputDirs) ? " not found " : " has " + reportOutputDirs.size() + " paths" ) 
                                          );

                                  List<String> destDirs = getConfiguration("destDir", plugin ) ;
                                  getLog().debug( "NewConfig- PLDoc destDirs " 
                                                  + ( (null == destDirs) ? " not found " : " has " + destDirs.size() + " paths" ) 
                                          );
                                  File reportOutputDirectory = null;

                                  for (String setting : reportOutputDirs )
                                  {
                                      reportOutputDirectory = new File(setting) ;
                                  }


                                  // Will any source code be saved 
                                  List<String> settings = getConfiguration("savesourcecode", plugin ) ;
                                  getLog().debug( "NewConfig- Attempting to locate Source XRef for pldoc plugins " );

                                  //PLDoc Root 
                                  File pldocRoot = null ; 
                                  for (String setting : destDirs )
                                  {
                                      if ( ( reportOutputDirectory != null ) 
                                           && ( setting != null ) 
                                           && ( !reportOutputDirectory.getAbsolutePath().endsWith( setting ) ) 
                                         )
                                      {
                                          pldocRoot = new File( reportOutputDirectory, setting );
                                      }
                                      else
                                      {
                                          pldocRoot = reportOutputDirectory;
                                      }
                                  }
                                  getLog().debug( "NewConfig- pldocRoot value is \""+ pldocRoot+ "\"");

                                  // Relative path to PLDoc Root 
                                  String pldocRootPath =
                                      PathTool.getRelativeFilePath( outputDirectory.getAbsolutePath(), pldocRoot.getAbsolutePath() );
                                  getLog().debug( "NewConfig- outputDirectory Absolute Path is \""+ outputDirectory.getAbsolutePath()+ "\"");
                                  getLog().debug( "NewConfig- pldocRoot Absolute Path is \""+ pldocRoot.getAbsolutePath()+ "\"");
                                  getLog().debug( "NewConfig- pldocRootPath value is \""+ pldocRootPath+ "\"");

                                  for (String setting : settings )
                                  {
                                    getLog().debug( "NewConfig- savesourcecode value is \""+ setting+ "\"");
                                    //Source Code will be or has been scraped
                                    if ("true".equalsIgnoreCase(setting) )
                                    {
                                      location = pldocRootPath;
                                      getLog().debug( "NewConfig- location set to pldocPath  \""+ pldocRootPath+ "\"");
                                    }
                                  }
                              } //plsql 
                               
                               
                             }
                           }
                         }


                      }




                    }
                }
                
                
            }

            if ( location == null )
            {
                getLog().warn( "Unable to locate Source XRef to link to - DISABLED" );
            }
        }
        getLog().debug( "constructXRefLocation: location==\""+location+"\"" );
        return location;
    }

    /**
     * Convenience method to get the list of files where the PMD tool will be executed
     *
     * @return a List of the files where the PMD tool will be executed
     * @throws java.io.IOException
     */
    protected Map<File, PmdFileInfo> getFilesToProcess()
        throws IOException
    {
      //String sourceXref = constructXRefLocation( false );
      //String testXref = includeTests ? constructXRefLocation( true ) : "";
        
      if ( aggregate && !project.isExecutionRoot() )
        {
            return Collections.emptyMap();
        }

        if ( excludeRoots == null )
        {
            excludeRoots = new File[0];
        }

        Collection<File> excludeRootFiles = new HashSet<File>( excludeRoots.length );

        for ( File file : excludeRoots )
        {
            if ( file.isDirectory() )
            {
                excludeRootFiles.add( file );
            }
        }

        List<PmdFileInfo> directories = new ArrayList<PmdFileInfo>();

	//Default to Project CompileSourceRoots if no Plug-in specific settings are defined  
        if ( null == compileSourceRoots )
	{
	  compileSourceRoots = project.getCompileSourceRoots();
	}

        if ( compileSourceRoots != null )
        {
            for ( String root : compileSourceRoots )
            {
	        getLog().debug( "Adding compile source root \"" + root + "\""  );
                File sroot = new File( root );
                if ( sroot.exists() )
                {
                    String sourceXref = constructXRefLocation( false );
                    directories.add( new PmdFileInfo( project, sroot, sourceXref ) );
                }
            }

        }

	//Default to Project ScriptSourceRoots if no Plug-in specific settings are defined  
        if ( null == scriptSourceRoots )
	{
	  scriptSourceRoots = project.getScriptSourceRoots();
	}

      //Add any scripts to be processed (Ruby,PLSQL) 
        if ( scriptSourceRoots != null )
        {

            for ( String root : scriptSourceRoots )
            {
	        getLog().debug( "Adding script source root \"" + root + "\""  );

                File sroot = new File( root );
                if ( sroot.exists() )
                {
                    String sourceXref = constructXRefLocation( false );
                    directories.add( new PmdFileInfo( project, sroot, sourceXref ) );
                }
            }

        }
        if ( includeTests )
        {
            if ( testSourceRoots != null )
            {
                for ( String root : testSourceRoots )
                {
                    File sroot = new File( root );
                    if ( sroot.exists() )
                    {
                        String testXref = constructXRefLocation( true );
                        directories.add( new PmdFileInfo( project, sroot, testXref ) );
                    }
                }
            }
        }
        if ( aggregate )
        {
            for ( MavenProject localProject : reactorProjects )
            {
                @SuppressWarnings( "unchecked" ) List<String> localCompileSourceRoots =
                    localProject.getCompileSourceRoots();
                for ( String root : localCompileSourceRoots )
                {
		    getLog().debug( "Adding local project compile root \"" + root + "\""  );
                    File sroot = new File( root );
                    if ( sroot.exists() )
                    {
                        String sourceXref = constructXRefLocation( false );
                        directories.add( new PmdFileInfo( localProject, sroot, sourceXref ) );
                    }
                }
                if ( includeTests )
                {
                    @SuppressWarnings( "unchecked" ) List<String> localTestCompileSourceRoots =
                        localProject.getTestCompileSourceRoots();
                    for ( String root : localTestCompileSourceRoots )
                    {
		      getLog().debug( "Adding local test root \"" + root + "\""  );
                        File sroot = new File( root );
                      if ( sroot.exists() )
                      {
                          String testXref = constructXRefLocation( true );
                          directories.add( new PmdFileInfo( localProject, sroot, testXref ) );
                      }
                    }
                }
            }
        }

        String excluding = getExcludes();
        getLog().debug( "Exclusions: " + excluding );
        String including = getIncludes();
        getLog().debug( "Inclusions: " + including );

        Map<File, PmdFileInfo> files = new TreeMap<File, PmdFileInfo>();

        for ( PmdFileInfo finfo : directories )
        {
            getLog().debug( "Searching for files in directory " + finfo.getSourceDirectory().toString() );
            File sourceDirectory = finfo.getSourceDirectory();
            if ( sourceDirectory.isDirectory() && !excludeRootFiles.contains( sourceDirectory ) )
            {
                @SuppressWarnings( "unchecked" ) List<File> newfiles =
                    FileUtils.getFiles( sourceDirectory, including, excluding );
                for ( File newfile : newfiles )
                {
		    getLog().debug( "Adding \"" + newfile + "\" to files"  );
                    files.put( newfile.getCanonicalFile(), finfo );
                }
            }
        }

        return files;
    }

    /**
     * Sets the list of effective include patterns for the specified language.
     *
     * @param languageString set includes from file extensions associated with the language
     */
    protected void setIncludes(String languageString)
    {
        Language language = LanguageRegistry.findLanguageByTerseName(languageString);
        List<String> patterns = new ArrayList<String>();
        
        if (null== language)
        {
          getLog().debug( "setIncludes: " + languageString + " failed to get Language"  );
        }
        else 
        {
          //Step through the associated file suffixes, adding a derived pattern
          for (String extension: language.getExtensions())
          {
                patterns.add( "**/*.".concat(extension) );
          }
          includes = patterns ;
        }
    }

    /**
     * Gets the comma separated list of effective include patterns.
     *
     * @return The comma separated list of effective include patterns, never <code>null</code>.
     */
    private String getIncludes()
    {
        Collection<String> patterns = new LinkedHashSet<String>();
        if ( includes != null )
        {
            patterns.addAll( includes );
        }
        if ( patterns.isEmpty() )
        {
          patterns.add( "**/*.java" );
        }
        return StringUtils.join( patterns.iterator(), "," );
    }

    /**
     * Gets the comma separated list of effective exclude patterns.
     *
     * @return The comma separated list of effective exclude patterns, never <code>null</code>.
     */
    private String getExcludes()
    {
        @SuppressWarnings( "unchecked" ) Collection<String> patterns =
            new LinkedHashSet<String>( FileUtils.getDefaultExcludesAsList() );
        if ( excludes != null )
        {
            patterns.addAll( excludes );
        }
        return StringUtils.join( patterns.iterator(), "," );
    }

    protected boolean isHtml()
    {
        return "html".equals( format );
    }
    protected boolean isXml()
    {
        return "xml".equals( format );
    }

    /**
     * {@inheritDoc}
     */
    public boolean canGenerateReport()
    {
        if ( aggregate && !project.isExecutionRoot() )
        {
            return false;
        }

        if ( "pom".equals( project.getPackaging() ) && !aggregate )
        {
            return false;
        }

        // if format is XML, we need to output it even if the file list is empty
        // so the "check" goals can check for failures
        if ( isXml() )
        {
            return true;
        }
        try
        {
            filesToProcess = getFilesToProcess();
            if ( filesToProcess.isEmpty() )
            {
                return false;
            }
        }
        catch ( IOException e )
        {
            getLog().error( e );
        }
        return true;
    }

    /**
     * {@inheritDoc}
     */
    protected String getOutputDirectory()
    {
        return outputDirectory.getAbsolutePath();
    }

    protected String getSourceEncoding()
    {
        return sourceEncoding;
    }

    /**
     * Gets the effective reporting output files encoding.
     *
     * @return The effective reporting output file encoding, never <code>null</code>.
     * @since 2.5
     */
    protected String getOutputEncoding()
    {
        return ( outputEncoding != null ) ? outputEncoding : ReaderFactory.UTF_8;
    }

    static String getPmdVersion()
    {
        try
        {
            return (String) PMD.class.getField( "VERSION" ).get( null );
        }
        catch ( IllegalAccessException e )
        {
            throw new RuntimeException( "PMD VERSION field not accessible", e );
        }
        catch ( NoSuchFieldException e )
        {
            throw new RuntimeException( "PMD VERSION field not found", e );
        }
    }

private ReportPlugin getPlugin(String key) {

    List plugins = getProject().getBuildPlugins();

    for (Iterator iterator = plugins.iterator(); iterator.hasNext();) {
        ReportPlugin plugin = (ReportPlugin) iterator.next();
        if(key.equalsIgnoreCase(plugin.getKey())) {
            return plugin;
        }
    }
    return null;
}


/**
 * Extracts nested values from the given config object into a List.
 * 
 * @param childname the name of the first subelement that contains the list
 * @param config   Plugin or ReportPlugin configuration 
 */
private List getConfiguration(String childname, Xpp3Dom config ) {

    //System.err.println("ReportPlugin(" + plugin.getArtifactId() +")");
    if (null == config )
    {
        System.err.println("ReportPlugin.config IS NULL");
    }
    else
    {
      System.err.println("ReportPlugin.subelement(" + childname +  ")");
      final Xpp3Dom subelement = config.getChild(childname);
      if (subelement != null) {
        System.err.println("ReportPlugin.subelement(" + childname +  ")=="+subelement.toString());
        List result = new LinkedList();
          final Xpp3Dom[] children = subelement.getChildren();
          if (null==children || 0 == children.length)
          { //Append the subelemnt value 
            result.add(subelement.getValue());
          }
          else
          {// Append all child values 
            for (Xpp3Dom child : children) {
              result.add(child.getValue());
            }
          }
          getLog().info("Extracted strings: " + result);
          return result;
      }
    }

    return null ;
  }

/**
 * Extracts nested values from the given config object into a List.
 * 
 * @param childname the name of the first subelement that contains the list
 * @param plugin the actual plugin 
 */
private List getConfiguration(String childname, ReportPlugin plugin ) {

    final Xpp3Dom config = (Xpp3Dom) plugin.getConfiguration() ;
    System.err.println("ReportPlugin(" + plugin.getArtifactId() +")");
    return getConfiguration( childname, config );
  }

/**
 * Extracts nested values from the given config object into a List.
 * 
 * @param childname the name of the first subelement that contains the list
 * @param plugin the actual plugin 
 */
private List getConfiguration(String childname, Plugin plugin ) {

    final Xpp3Dom config = (Xpp3Dom) plugin.getConfiguration() ;
    System.err.println("ReportPlugin(" + plugin.getArtifactId() +")");
    return getConfiguration( childname, config );
  }


}
