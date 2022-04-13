<cfscript>
	benchmark_config = {
		testName = "Local Variables",
		testDescription = "Test the setting of variables with or without var",
		maxIterations = 500000	
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Not using var");
</cfscript>
	<cfscript>
		function loop1() {
			for(i = 1; i lte benchmark.maxIterations; i += 1)
				a = i;
		}
		
		loop1();
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("Using var");
</cfscript>
	<cfscript>
		function loop2() {
			var a = 0;
			for(var i = 1; i lte benchmark.maxIterations; i += 1)
				a = i;
		}
		
		loop2();
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
