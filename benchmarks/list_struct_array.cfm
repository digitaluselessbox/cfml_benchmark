<cfscript>
	benchmark_config = {
		testName = "List, Struct, Array",
		testDescription = "compare the speed of list, struct and array setting",
		maxIterations = 250000		
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();

	maxElements = 4;
	length = 0;
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Array");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfscript>
			array = ArrayNew(1);
			for(i = 1; i lte maxElements; i += 1) {
				ArrayAppend(array, i * i);
			}
			
			length = ArrayLen(array);
			for(i = 1; i lte length; i += 1) {
				array[i] = array[i] + 1;
			}
		</cfscript>
	</cfloop>
<cfscript>
	benchmark.end( array );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Struct");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfscript>
			struct = StructNew();
			for(i = 1; i lte maxElements; i += 1) {
				StructInsert(struct, i, i * i);
			}
			
			length = StructCount(struct);
			for(i = 1; i lte length; i += 1) {
				struct[i] = struct[i] + 1;
			}
		</cfscript>
	</cfloop>
<cfscript>
	benchmark.end( struct );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("List");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfscript>
			list = "";
			for(i = 1; i lte maxElements; i += 1) {
				list = ListAppend(list, i * i);
			}
			
			length = ListLen(list);
			for(i = 1; i lte length; i += 1) {
				list = ListSetAt(list, i, ListGetAt(list, i) + 1);
			}
		</cfscript>
	</cfloop>
<cfscript>
	benchmark.end( list );
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
