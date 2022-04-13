<cfscript>
	benchmark_config = {
		testName = "Assignments",
		testDescription = "test the speed of several cfloops",
		maxIterations = 5000000
	};	
	
	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("cfloop / cfscript");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfscript>
			a = i;
		</cfscript>
	</cfloop>
<cfscript>
	benchmark.end( {} );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfloop / cfset");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfset a = i>
	</cfloop>
<cfscript>
	benchmark.end( {} );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfscript loop&set");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1)
			a = i;
	</cfscript>
<cfscript>
	benchmark.end( {} );
</cfscript>


<!--- Visualize --->
<cfset benchmark.writeFooter() />

