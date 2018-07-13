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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
//import java.util.logging.Logger;

import net.sourceforge.pmd.Report;
import net.sourceforge.pmd.ReportListener;
import net.sourceforge.pmd.RuleViolation;
import net.sourceforge.pmd.stat.Metric;

/**
 * Handle events from PMD and collect violations.
 */
public class PmdReportListener
    implements ReportListener
{
    //private final static Logger LOGGER = Logger.getLogger(PmdReportListener.class.getName()); 
    private HashSet<RuleViolation> violations = new HashSet<RuleViolation>();

    private List<Metric> metrics = new ArrayList<Metric>();

    /**
     * {@inheritDoc}
     */
    public void ruleViolationAdded( RuleViolation ruleViolation )
    {
        violations.add( ruleViolation );
    }

    public List<RuleViolation> getViolations()
    {
        return new ArrayList<RuleViolation>( violations );
    }

    public boolean hasViolations()
    {
        return !violations.isEmpty();
    }

    //SRT - Start
    public List<Metric> getMetrics()
    {
	//SRT System.err.println("SRT: getMetrics()="+metrics.size());
        return new ArrayList<Metric>( metrics );
    }

    public boolean hasMetrics()
    {
        return !metrics.isEmpty();
    }
    //SRT - End

    /**
     * Create a new single report with all violations for further rendering into other formats than HTML.
     */
    public Report asReport()
    {

	//SRT System.err.println("SRT: asReport");
	//SRT Thread.currentThread().dumpStack();

        Report report = new Report();
        for ( RuleViolation v : violations )
        {
            report.addRuleViolation( v );
        }
	/*
	System.err.println("SRT: asReport()="+metrics.size());
        for ( Metric m : metrics )
        {
            report.addMetric( m );
        }
	*/
        return report;
    }

    /**
     * {@inheritDoc}
     */
    public void metricAdded( Metric metric )
    {
        /*
	System.err.println("SRT: metricAdded="+metric.getMetricName()
			+",getMetricName()="+metric.getMetricName()
			+",getLowValue()="+metric.getLowValue()
			+",getHighValue()="+metric.getHighValue()
			+",getAverage()="+metric.getAverage()
			+",getStandardDeviation()="+metric.getStandardDeviation()
			+",getCount()="+metric.getCount()
			+",getTotal()="+metric.getTotal()
		     );
        */
	//System.err.println("SRT: metricAdded..."+metric.getMetricName()
	//SRT Thread.currentThread().dumpStack();


        if ( metric.getCount() != 0 )
        {
	    //SRT System.err.println("SRT: metricAdded: ADDING METRICS");
            // Skip metrics which have no data
            metrics.add( metric );
        }
    }
}
