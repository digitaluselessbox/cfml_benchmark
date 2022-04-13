<cfscript>
	benchmark_config = {
		testName = "saveContent vs Set",
		testDescription = "Test speed of cfSaveContent vs. cfset! Of course there are some kind of situations i like to use savecontent, but obviously it is not that fast.",
		maxIterations = 3000000		
	};	

	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();

	x = "";
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfsavecontent");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfsavecontent variable="x">Hello World</cfsavecontent>
	</cfloop>
<cfscript>
	benchmark.end();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfset");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfset x = "Hello World" />
	</cfloop>
<cfscript>
	benchmark.end();
</cfscript>

 bvv
<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
