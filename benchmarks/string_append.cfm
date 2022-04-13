<cfscript>
	benchmark_config = {
		testName = "StringAppend()",
		testDescription = "test the speed of different string concatination methods",
		maxIterations = 160000
	};	

	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("multiple lines", "Here we concate the text together with '&='.");
</cfscript>
	<cfscript>
		string function loop1() {
			local.html = " ";
			
			local.html &= "abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d a";
			local.html &= "abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d b";
			local.html &= "abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d c";
			local.html &= "abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d d";
			local.html &= "abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d e";			
			
			return local.html;
		}
		
		for(i = 1; i lte benchmark.maxIterations; i += 1){
			result = loop1();
		}	
	</cfscript>
<cfscript>
	benchmark.end(result);
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("single lines","In this benchmark we use one cfset with all the text in it.");
</cfscript>
	<cfscript>
		string function loop2() {
			local.html = " 
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d a
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d b
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d c
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d d
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d e
			";
			
			return local.html;
		}
		
		for(i = 1; i lte benchmark.maxIterations; i += 1){
			result = loop2();
		}
	</cfscript>
<cfscript>
	benchmark.end(result);
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("cfsavecontent","All the text in one CFSavecontent-Tag");
</cfscript>
<cfoutput>
	<cffunction name="loop3">
		<cfsavecontent variable="local.html">
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d a
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d b
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d c
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d d
			abc hghlf fglhfkghl alsfdkgoesdfjg soedlfgisdfoe sdfgsdf sgdfgsdf gs dfgs dfg dfg d e
		</cfsavecontent>
		
		<cfreturn local.html>
	</cffunction>

	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1){
			result = loop3();
		}
	</cfscript>
</cfoutput>	
<cfscript>
	benchmark.end( result );
</cfscript>


<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>
