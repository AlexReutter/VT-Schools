Burlington, VT, School Enrollment
================
Alex Reutter
2017-11-12

-   [Background](#background)
-   [Summary](#summary)
-   [Data sources](#data-sources)
    -   [Vermont Agency of Education](#vermont-agency-of-education)
    -   [Burlington School District Annual Reports](#burlington-school-district-annual-reports)
-   [Analyses](#analyses)
    -   [Processing the original reports](#processing-the-original-reports)
    -   [State-level analysis](#state-level-analysis)
    -   [Chittenden county-level analysis](#chittenden-county-level-analysis)
    -   [Focus on Burlington](#focus-on-burlington)

The purpose of this project is to help shed some light on questions surrounding enrollment in schools in Vermont, especially the Burlington district. It is a reference from which easier-to-consume conclusions and recommendations can be drawn.

Background
----------

The school district of Burlington, VT, is in its nth consecutive year of staff cuts, and parents are concerned about whether these cuts will adversely affect the quality of education provided by the district.

Summary
-------

While there is good evidence that statewide and Chittenden countywide enrollment is dropping, the data show that Burlington's K-12 enrollment has been stable over the last 14 years, and the expansion of the Pre-K program has actually increased total enrollment since 2003.

Data sources
============

Vermont Agency of Education
---------------------------

The VT Agency of Education (VTAoE)maintains a [portal where you can download reports of enrollment at Vermont’s Public schools](http://edw.vermont.gov/REPORTSERVER/Pages/ReportViewer.aspx?%2fPublic%2fEnrollment+Report). The data goes back to the 2003-2004 school year. Because it is time-consuming to submit the requests and download the data, I have saved original copies of Excel exports produced by the portal in this public GitHub repository.

Burlington School District Annual Reports
-----------------------------------------

The school district produces [annual reports](http://district.bsd.schoolfusion.us/modules/cms/pages.phtml?pageid=309846) that are publicly available. The numbers from the BSD Annual Reports are slightly different from the VTAOE numbers; my understanding is that this is because the numbers in each of the reports are pulled at different times of the school year, and enrollment fluctuates over the course of the school year.

The plots in this project are based on the VTAoE data.

Analyses
========

In order to make this analysis open and replicable, the code used to produce the analysis is in this public GitHub repository. At the moment, I am using R code to work with the data.

Processing the original reports
-------------------------------

Unfortunately, the VTAOE reports are not in good condition for performing further analysis. In order to get the data into shape, I wrote the data processing.r file. This processing file combines the reports and restructures them into a single dataset with the following columns:

-   School, which identifies the school
-   OperatingDistrict, which identifies the operating district the school is a part of
-   SupervisoryUnion, which identifies the supervisory union or school district that the operating district is a part of
-   County, which identifies the county in which the supervisory union operates
-   Grade, which identifies the grade for which enrollment is reported. VTAOE does not have classroom-level data
-   Year, which identifies the year that the school term ends; thus, rows with the value 2014 for Year report enrollment for the 2013-2014 school year
-   Enrollment, which is the number of students enrolled in a given year in a given grade at a given school

State-level analysis
--------------------

It is clear that, in Vermont as a whole, total K-12 enrollment is decreasing, and over the last 14 years, the decline is near the [20% claimed by Sec. Holcombe](http://www.burlingtonfreepress.com/story/news/local/vermont/2017/10/19/vermont-education-budget-gap-may-have-burlington-tightening-its-belt/745578001/).

![](./README-fig/unnamed-chunk-3-1.png)

The plot below shows that the rate of decline differs from county to county. There is a separate line to represent each county, which shows the enrollment in that county, relative to the maximum enrollment observed over the last 13 years. Essex and Grafton counties have experienced the most severe declines, while Lamoille and Chittenden county have seen the least declines.

![](./README-fig/unnamed-chunk-4-1.png)

This chart displays a ratio rather than the total enrollment because this makes the year-to-year changes easier to compare across counties.

Chittenden county-level analysis
--------------------------------

Let’s look more closely at the supervisory unions and school districts within Chittenden county. This is the same style of plot as shown for comparing the county-to-county enrollment, but here there is a separate line to represent each supervisory union or school district.

What this plot shows is that, within Chittenden county, most districts appear to have experienced a decline in K-12 enrollment; however, Burlington has held steady.

![](./README-fig/unnamed-chunk-5-1.png)

Focus on Burlington
-------------------

The following table shows the year-by-year total enrollment in Burlington School District, not including the Pre-K students.

|  year|  EnrollmentSum|  maxEnrollment|  enrollmentRatio|
|-----:|--------------:|--------------:|----------------:|
|  2004|           3535|           3611|        0.9789532|
|  2005|           3517|           3611|        0.9739684|
|  2006|           3510|           3611|        0.9720299|
|  2007|           3515|           3611|        0.9734146|
|  2008|           3487|           3611|        0.9656605|
|  2009|           3498|           3611|        0.9687067|
|  2010|           3466|           3611|        0.9598449|
|  2011|           3556|           3611|        0.9847688|
|  2012|           3527|           3611|        0.9767377|
|  2013|           3588|           3611|        0.9936306|
|  2014|           3611|           3611|        1.0000000|
|  2015|           3549|           3611|        0.9828302|
|  2016|           3567|           3611|        0.9878150|
|  2017|           3502|           3611|        0.9698145|

This chart breaks it down by school.

![](./README-fig/unnamed-chunk-7-1.png)

The following table shows the year-by-year total enrollment in Burlington School District, *including* the Pre-K children.

|  year|  EnrollmentSum|  maxEnrollment|  enrollmentRatio|
|-----:|--------------:|--------------:|----------------:|
|  2004|           3611|           4006|        0.9013979|
|  2005|           3577|           4006|        0.8929106|
|  2006|           3589|           4006|        0.8959061|
|  2007|           3546|           4006|        0.8851722|
|  2008|           3520|           4006|        0.8786820|
|  2009|           3549|           4006|        0.8859211|
|  2010|           3527|           4006|        0.8804294|
|  2011|           3613|           4006|        0.9018972|
|  2012|           3606|           4006|        0.9001498|
|  2013|           3970|           4006|        0.9910135|
|  2014|           4006|           4006|        1.0000000|
|  2015|           3971|           4006|        0.9912631|
|  2016|           3962|           4006|        0.9890165|
|  2017|           3950|           4006|        0.9860210|

This chart breaks it down by school.

![](./README-fig/unnamed-chunk-9-1.png)

That is the Champlain School whose enrollment suddenly jumped in the 2012-2013 school year, due to the addition of Pre-K students.

|  year|  EnrollmentSum|  maxEnrollment|  enrollmentRatio|
|-----:|--------------:|--------------:|----------------:|
|  2004|            287|            667|        0.4302849|
|  2005|            278|            667|        0.4167916|
|  2006|            293|            667|        0.4392804|
|  2007|            290|            667|        0.4347826|
|  2008|            288|            667|        0.4317841|
|  2009|            317|            667|        0.4752624|
|  2010|            324|            667|        0.4857571|
|  2011|            337|            667|        0.5052474|
|  2012|            334|            667|        0.5007496|
|  2013|            626|            667|        0.9385307|
|  2014|            637|            667|        0.9550225|
|  2015|            635|            667|        0.9520240|
|  2016|            615|            667|        0.9220390|
|  2017|            667|            667|        1.0000000|
