<cfscript>
	benchmark_config = {
		testName = "string empty",
		testDescription = "Test speed of methods to check for an empty string.",
		maxIterations = 2750000,
		testData = {
			emptyString = "",
			textString = "abcdefg" 
		}
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();

	
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("len with empty string");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(len(benchmark.testData.emptyString)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("len with text string");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(len(benchmark.testData.textString)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("eq ''  with empty string");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(benchmark.testData.emptyString eq "") {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>



<!--- TestBlock --->
<cfscript>
	benchmark.start("eq '' with text string");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(benchmark.testData.textString eq "") {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock ---> 
<!--- this benchmark is in Adobe CF not available, because isEmpty() doesn't exist --->
<cftry>
	<cfscript>
		benchmark.start("isEmpty() with empty string");
	</cfscript>
		<cfscript>
			for(i = 1; i lte benchmark.maxIterations; i += 1) {
				if(isEmpty(benchmark.testData.emptyString)) {
				}
			}
		</cfscript>
	<cfscript>
		benchmark.end();
	</cfscript>

	<cfcatch>
		<cfset benchmark.end("isEmpty() ist fuer AdobeCF nicht verfuegbar!")>
	</cfcatch>
</cftry>

<!--- TestBlock ---> 
<!--- this benchmark is in Adobe CF not available, because isEmpty() doesn't exist --->
<cftry>
	<cfscript>
		benchmark.start("isEmpty() with text string");
	</cfscript>
		<cfscript>
			for(i = 1; i lte benchmark.maxIterations; i += 1) {
				if(isEmpty(benchmark.testData.textString)) {
				}
			}
		</cfscript>
	<cfscript>
		benchmark.end();
	</cfscript>

	<cfcatch>
		<cfset benchmark.end("isEmpty() ist fuer AdobeCF nicht verfuegbar!")>			
	</cfcatch>
</cftry>

<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
