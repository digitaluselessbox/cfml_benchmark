<cfscript>
	benchmark_config = {
		testName = "Looping Array",
		testDescription = "how is the speed of different methodes to loop an array",
		testData = ['a','b','c','d','e'],
		maxIterations = 125000,
		chartwidth = 500,
		chartheight = 800,
		outputResults = true
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("CFLoop");
</cfscript>

<cfloop index="i" from="1" to="#benchmark.maxIterations#">
	<cfloop from="1" to="#arrayLen(benchmark.testData)#" index="loopIndex"></cfloop>
</cfloop>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript for","if it was in cfscript it would have been");
</cfscript>
	<cfscript>
		for(x = 1; x lte benchmark.maxIterations; x += 1) {
			for (i = 1; i <= arrayLen(benchmark.testData); i++) {
				
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript tag","You can also use the tags-in-script version:");
</cfscript>
	<cfscript>
		for(x = 1; x lte benchmark.maxIterations; x += 1) {
			cfloop(from="1", to="#arrayLen(benchmark.testData)#", index="loopIndex"){
				
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfloop with item and index", "Using the array, item and index attributes with the cfloop tag.");
</cfscript>
	
<cfloop index="i" from="1" to="#benchmark.maxIterations#">
	<cfloop array="#benchmark.testData#" item="loopItem" index="loopIndex"></cfloop>
</cfloop>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript tag with item and index", "You can also use the tags-in-script version of this");
</cfscript>
	
<cfscript>
	for(x = 1; x lte benchmark.maxIterations; x += 1) {
		cfloop(from="1", to="#arrayLen(benchmark.testData)#", index="loopIndex"){
			
		}
	}
</cfscript>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript for-in", "You can also use the tags-in-script version of this");
</cfscript>
	
<cfscript>
	for(x = 1; x lte benchmark.maxIterations; x += 1) {
		for (loopItem in benchmark.testData) { } 
	}
</cfscript>

<cfscript>
	benchmark.end();
</cfscript>



<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript arrayeach", "");
</cfscript>
	
<cfscript>
	for(x = 1; x lte benchmark.maxIterations; x += 1) {
		arrayEach(benchmark.testData, function(loopItem,loopIndex) {});
	}
</cfscript>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript each", "the array each member function");
</cfscript>
	
<cfscript>
	for(x = 1; x lte benchmark.maxIterations; x += 1) {
		benchmark.testData.each(function(loopItem, loopIndex) { 
			
		});
	}
</cfscript>

<cfscript>
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>