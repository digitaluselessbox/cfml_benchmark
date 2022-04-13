<cfscript>
	benchmark_config = {
		testName = "CFLoop vs. CFOutput",
		testDescription = "test the speed of a tag based cfloop vs tag base loop with cfoutput",
		maxIterations = 100000
	};	

	// creating test data a query with 100 hash values and a id column
	benchmark_config.testData = QueryNew("id, name", "Integer, VarChar");
	for(x = 1; x lte 100; x += 1) {
		QueryAddRow(benchmark_config["testData"]);
		QuerySetCell(benchmark_config["testData"], "id",x);
		QuerySetCell(benchmark_config["testData"], "name",hash(x,"MD5"));
	}
	
	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript>


<!--- ######## cfloop query TEST ######## --->
<!--- test block --->
<cfset benchmark.start("Schleife mit CFLoop") />
<cfloop from="1" to="#benchmark.maxIterations#" index="y">
	<cfoutput>
		<cfloop query='benchmark.testData'>
			<cfset nothing = y />
		</cfloop>
	</cfoutput>
</cfloop>
<cfset benchmark.end() />

<!--- ######## cfoutput query TEST ######## --->
<!--- test block --->
<cfset benchmark.start("Schleife mit CFOuotput") />
<cfloop from="1" to="#benchmark.maxIterations#" index="z">
	<cfoutput query='benchmark.testData'>
		<cfset nothing = z />
	</cfoutput>
</cfloop>
<cfset benchmark.end() />


<!--- Visualize --->
<cfset benchmark.writeFooter() />