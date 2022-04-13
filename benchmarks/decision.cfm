<cfscript>
	benchmark_config = {
		testName = "Decision",
		testDescription = "Test the speed of several decision types with an integer variable",
		maxIterations = 100000,
		testData = 123
	};	
		
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();	
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("isNumeric");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isNumeric(benchmark.testData)) {
				asd = 1;
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isDate");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isDate(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isNumericDate");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isNumericDate(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isQuery");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isQuery(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isBoolean");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isBoolean(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isArray");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isArray(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isNull");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isNull(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isStruct");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isStruct(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isObject");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isObject(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isSimpleValue");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isSimpleValue(benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isValid('integer')");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isValid("integer", benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isValid('query')");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isValid("query", benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isValid('date')");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isValid("date", benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isValid('time')");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isValid("time", benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("isValid('component')");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isValid("component", benchmark.testData)) {
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<!--- <cfscript>
	benchmark.start("isInstanceOf");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isInstanceOf(a, "SomeCustomCFC")) {
				
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>
 --->

<!--- Visualize --->
<cfset benchmark.writeFooter() />