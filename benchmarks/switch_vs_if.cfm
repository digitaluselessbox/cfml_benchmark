<cfscript>
	benchmark_config = {
		testName = "switch vs. if vs iif",
		testDescription = "Test three 'conditional statement' variants.",
		maxIterations = 400000
	};	

	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfswitch with 3", "cfswitch with 3 conditions");
</cfscript>

<cfset val = 2>
<cfloop index="i" from="1" to="#benchmark.maxIterations#">
	<cfswitch expression="#val#">
		<cfcase value="1"></cfcase>
		<cfcase value="2"></cfcase>
		<cfcase value="3"></cfcase>
	</cfswitch>
</cfloop>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("switch with 3", "cfscript - switch with 3 conditions");
	
	val = 2;
	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		switch(val) {
		    case "1": break;
		    case "2": break;
		    case "3": break;
		}
	}
	
	benchmark.end();
</cfscript>



<!--- TestBlock --->
<cfscript>
	benchmark.start("cfif with 3", "cfif/cfelseif with 3 conditions");
</cfscript>

<cfset val = 2>
<cfloop index="i" from="1" to="#benchmark.maxIterations#">
	<cfif val IS 1>
	<cfelseif val IS 2>
	<cfelseif val IS 3>
	</cfif>
</cfloop>

<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("if with 3","cfscript - if/else if with 3 conditions");
	
	val = 2;
	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		if(val == 1){}
		else if(val == 2){}
		else if(val == 3){}
	}
	
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("iif with 3", "cfscript - 3 nested iif conditions");
	
	val = 2;
	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		iif(val==1, "", iif(val==2, '', iif(val==3, '', '')));
	}
	
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
