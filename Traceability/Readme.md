![Archive](./Images/Archive.png)
<br>
<h3 align=center>I am working with a document archive</h2>
<h4 align=center>Photo by C M on Unsplash.</h3>
<br>


# End-to-End Trace Matrix
<style>

    img[src*='#center'] { 
    display: block;
    margin: auto;

}
</style>

## Abstract 

This analyis looks at tracing requirements from the marketing requirements through to the test results. I am going to begin this analysis using power query because I like how it allows you to explore the data quickly.

I expect the following from my exploratory data analysis:

* Determine whether every market requirement is covered by a test case
* Decide on the format of the report.<br>This is a bit complicated because there the system specifications and test reports are broken down by program name.
* Determine if there are test reports with no corresponding user requriements.<br>This should not be an issue with respect to traceablity, but it will help understanding what is going on. 

## Background

### Document Structure

My requirements flowdown in the following manner.

[<img src="Images/DocStructure.png#center" width="250"/>](Images/DocStructure.png#center)