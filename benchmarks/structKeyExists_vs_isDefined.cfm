<cfscript>
	benchmark_config = {
		testName = "existence checks",
		testDescription = "<p>Compare speed of several checks for existence.<br>According to the fact, that isdefined() checks every part of the Struct/Array-Tree there are two thing s to explain.</p>"
							& "First: <br>"
							& "Test splits into tiny and deep tree check.<br><br>"
							& "Second: <br>"
							& "To make structKeyExists() more compereable there is a deep-tree test with structkeyExists() for each branch.<br><br>",

		maxIterations = 300000,
		testData = {
			innerArray = [
				{
					innerStruct={
						subInnerStruct = {}
					}
				},
				{
					innerStruct ={
						subInnerStruct = {
							testvalue = ""
						}
					}
				}
			]
		}
	};	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("structKeyExists() - deep tree - direct", "structkeyExists only check the last struct testvalue");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(structkeyExists(benchmark.testData.innerArray[2].innerStruct.subInnerStruct, "testvalue")){
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("structKeyExists() - deep tree - each branch", "structkeyExists like isdefined(). Test every 'struct-level' with structkeyExists() until testvalue");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(	StructKeyExists(benchmark.testData, "innerArray") 
				AND StructKeyExists(benchmark.testData.innerArray[2], "innerStruct") 
				AND StructKeyExists(benchmark.testData.innerArray[2].innerStruct, "subInnerStruct") 
				AND StructKeyExists(benchmark.testData.innerArray[2].innerStruct.subInnerStruct, "testvalue") 
			) {
			} 
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cftry>
	<cfscript>
		benchmark.start("isDefined() - deep tree","with a deep struct tree.<br>benchmark.testData.innerArray[2].innerStruct.subInnerStruct.testvalue");
	</cfscript>
		<cfscript>
			for(i = 1; i lte benchmark.maxIterations; i += 1) {
				if(isDefined("benchmark.testData.innerArray['2'].innerStruct.subInnerStruct.testvalue")) {
					
				}
			}
		</cfscript>
	<cfscript>
		benchmark.end();
	</cfscript>

	<cfcatch>
		<cfset benchmark.end("Adobe CF cannot handle 'complex' deep tree variable path with a mix of array and struct in isdefined().")>
	</cfcatch>
</cftry>	

<!--- TestBlock --->
<cfscript>
	benchmark.start("isDefined() - tiny tree","with a tiny struct tree.<br>benchmark.testData");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(isDefined("benchmark.testData")) {
				
			}
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("structKeyExists() - tiny tree", "with a tiny struct tree.<br>benchmark.testData");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			if(	StructKeyExists(benchmark_config, "testData")) {
			} 
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
