<cfscript>
	benchmark_config = {
		testName = "Struct vs. Array ",
		testDescription = "compare speed of Struct and Array, with setting of simple values. The test ist not quiet realastic and not fair. because you never use a struct for this. ;)",
		maxIterations = 600000		
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();

	variables.myStruct = StructNew();
	variables.myArray = ArrayNew(1);
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Struct");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			variables.myStruct[i] = i * 2;
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Array");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			variables.myArray[i] = i * 2;
		}
	</cfscript>
<cfscript>
	benchmark.end();
</cfscript>

<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
