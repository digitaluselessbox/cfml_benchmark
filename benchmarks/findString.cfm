<cfscript>
	benchmark_config = {
		testName = "find a String",
		testDescription = "test speed of several string find methods.",
		maxIterations = 2000000,
		testData = "release"
	};	

	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript>



<!--- TestBlock --->
<cfscript>
	benchmark.start("or operator");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if((benchmark.testData IS "update" OR benchmark.testData IS "insert")) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("listfind");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if((listfind("update,insert", benchmark.testData))) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("ListContains");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if((ListContains("update,insert", benchmark.testData))) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("find");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if((find(benchmark.testData, "update,insert"))) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("findnocase");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if((findnocase(benchmark.testData, "update,insert"))) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfset benchmark.writeFooter() />
