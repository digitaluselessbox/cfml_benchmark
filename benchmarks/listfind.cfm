<cfscript>
	benchmark_config = {
		testName = "find a string in list();",
		testDescription = "test speed of several list find methods.",
		maxIterations = 500000,
		testData = {
			data = {
				"resultList" = "1,2,3,4,5,6,7,8",
				"searchlist" = "47,33,86,10,12,18,19,8",
				"delimiter" = ",",
				"flag" = 0},
			searchString = 86
			
		}
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("ListFind + listGetAt");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			result = listGetAt( 
				benchmark.testData.data.resultList, 
				listFindNoCase( 
					benchmark.testData.data.searchlist, 
					benchmark.testData.searchString, 
					benchmark.testData.data.delimiter 
				) 
			);
		}
	</cfscript>
<cfscript>
	benchmark.end(result);
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("listContains + listGetAt");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			result = listGetAt( benchmark.testData.data.resultList, 
				listContains( 
					benchmark.testData.data.searchlist, 
					benchmark.testData.searchString, 
					benchmark.testData.data.delimiter 
				)
			);
		}
	</cfscript>
<cfscript>
	benchmark.end(result);
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("ListToArray + ArrayFind");

	resultArray = listToArray( benchmark.testData.data.resultList, benchmark.testData.data.delimiter );
	searchArray = listToArray( benchmark.testData.data.searchlist, benchmark.testData.data.delimiter );

	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		result = resultArray[ arrayFind( searchArray, benchmark.testData.searchString ) ];
	}

	benchmark.end(result);
</cfscript>




<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>