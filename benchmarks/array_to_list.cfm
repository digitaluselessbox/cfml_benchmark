<cfscript>
	benchmark_config = {
		testName = "Array To List",
		testDescription = "
			Test the speed of several methods to convert an array to a list.<br> 
			The idea of string concate array elements to a list is no good idea. It is 50% slower than using listAppend().<br>
			The fastes way is the core function arrayToList().<br>
			The slowest way is a loop with arrayEach(),  most likely due to the callback-function.
		",
		maxIterations = 800000,
		testData = [ "item1","item2","item3","item4","item5" ]
	};	

	benchmark = new benchmark( config = benchmark_config ); // init benchmark component
	benchmark.writeHeader();
</cfscript>

<!--- TestBlock --->
<cfset benchmark.start("CFLoop(Array) & concate","Using CFLoop-tag with parameter array and append each array item with string concatination in CFML-Tag") />

	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		
		<cfset result = ""> 
		<cfloop array="#benchmark.testData#" index="i"> 
			<cfset result &= i & ","> 
		</cfloop>
		<cfif len(result)>
			<cfset result = left(result,len(result)-1)> 
		</cfif>	

	</cfloop>

<cfset benchmark.end( result ) />


<!--- TestBlock --->
<cfset benchmark.start("CFLoop(Array) & listappend","Using CFLoop-tag with parameter array and append each array item to a string with ListAppend()") />

	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfset result = ""> 
		<cfloop array="#benchmark.testData#" index="i"> 
			<cfset result = ListAppend(result, i)>
		</cfloop>
	</cfloop>

<cfset benchmark.end( result ) />


<!--- TestBlock --->
<cfscript>
	benchmark.start("FOR-IN Loop","FOR-IN loop in script notation with listAppend()");

		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			result = "";
			for (element in benchmark.testData) {
				result = listAppend(result, element);
			}
		}
	
	benchmark.end( result );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("arrayToList()","Very simple, using the CF core function arrayToList() in script notation. For your information. Tag notation of this test has same times.");

	for(i = 1; i lte benchmark.maxIterations; i += 1) {
			result = ArrayToList(benchmark.testData);
		}
		
	benchmark.end( result );
</cfscript>


<!--- Visualize --->
<cfset benchmark.writeFooter() />
