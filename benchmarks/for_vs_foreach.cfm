<cfscript>
	benchmark_config = {
		testName = "for vs. foreach",
		testDescription = "test the speed of several methods to convert an array to a list.",
		maxIterations = 200000,
		testData = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ]
	};	
	
	benchmark = new benchmark( config = benchmark_config ); // init benchmark component
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Foreach");
</cfscript>
	<cfscript>
		function loop1() {
			for(var i = 1; i lte benchmark.maxIterations; i += 1) {
				var a = 0;
				
				for(var element in benchmark.testData) {
					a = element;
				}
			}
		}
		
		loop1();
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("For");
</cfscript>
	<cfscript>
		function loop2() {
			for(var i = 1; i lte benchmark.maxIterations; i += 1) {
				var a = 0;
				var ar = benchmark.testData;
				var aLen = ArrayLen(ar);
				
				for(var index = 1; index < aLen; index += 1) {
					a = ar[index];
				}
			}
		}
		
		loop2();
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfset benchmark.writeFooter() />