<cfscript>
	benchmark_config = {
		testName = "CFLock",
		testDescription = "test the time loss of using cflock",
		maxIterations = 500
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
			<!--- donothing --->
		</cflock>
	</cfloop>
<cfscript>
	benchmark.end( {} );
</cfscript>