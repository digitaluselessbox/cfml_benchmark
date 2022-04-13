<cfscript>
	benchmark_config = {
		testName = "CreateObject() vs new Object()",
		testDescription = "Test the speed of the two object instanciation possibilities",
		maxIterations = 1000
	};	
	
	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript> 

<!--- TestBlock --->
<cfscript>
	benchmark.start("CreateObject");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			a = CreateObject("component", "Benchmark").init();
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("new");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			b = new Benchmark();
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- Visualize --->
<cfset benchmark.writeFooter( {} ) />