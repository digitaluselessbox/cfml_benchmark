<cfscript>
	benchmark_config = {
		testName = "CFLock",
		testDescription = "test the time loss of using a pure cflock-tag",
		maxIterations = 500000
	};	
	
	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("paralel locks");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cflock name="this_is_myLock_#i#">
			<cfset test = i/>
			<!--- donothing --->
		</cflock>
	</cfloop>
<cfscript>
	benchmark.end( {} );
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>