<cfcomponent>
	<cfscript>
		This.name="cfbenchmark";
		This.clientmanagement="True";
		This.loginstorage="Session" ;
		This.sessionmanagement="True" ;
		This.sessiontimeout=CreateTimeSpan(1,0,0,0);
	</cfscript>

	<cffunction name="onApplicationStart">
		<cfset application.benchmark_folder = "benchmarks\" />
	</cffunction>

	<!--- enablecfoutputonly is very important. Due to the many testloop the 
		ammount of cf space characters will genrate content size of many MB --->
	<cfsetting showdebugoutput="NO" enablecfoutputonly="YES">
</cfcomponent>
