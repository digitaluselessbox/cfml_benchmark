<cfscript>
	benchmark_config = {
		testName = "List to Array",
		testDescription = "test speed of three different ways to transform a list to an array.",
		maxIterations = 1500000		
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("ArrayAppend");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			x = ArrayNew(1);
			ArrayAppend(x, "Hello");
			ArrayAppend(x, "World");
			ArrayAppend(x, "!");
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Assignment");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			x = ArrayNew(1);
			x[1] = "Hello";
			x[2] = "World";
			x[3] = "!";
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("ListToArray");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			x = ListToArray("Hello,World,!");
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
