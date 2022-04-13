<cfscript>
	benchmark_config = {
		testName = "Test of different relational operators ",
		testDescription = "test the speed of several methods to compare two values of different type with 'equal to'. (EQ,IS) ",
		maxIterations = 5000000
	};	
	
	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- integers only --->
<!--- test block --->
<cfset benchmark.start("IS-Operator","with integers only") />
	<cfset a = 1 />
	<cfset b = 2 />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a is b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("EQ-Operator","with integers only") />
	<cfset a = 1 />
	<cfset b = 2 />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a eq b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("'=='-Operator","with integer only") />
	<cfset a = 111 />
	<cfset b = 222 />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a == b></cfif>
	</cfloop>
<cfset benchmark.end() />



<!--- strings only  --->
<!--- test block --->
<cfset benchmark.start("IS-Operator","with strings only") />
	<cfset a = "aaa" />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a is b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("EQ-Operator","with strings only") />
	<cfset a = "aaa" />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a eq b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("'=='-Operator","with strings only") />
	<cfset a = "aaa" />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a == b></cfif>
	</cfloop>
<cfset benchmark.end() />



<!--- mixing of string and integer --->
<!--- test block --->
<cfset benchmark.start("IS-Operator","with string and integer") />
	<cfset a = 111 />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a is b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("EQ-Operator","with string and integer") />
	<cfset a = 111 />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a eq b></cfif>
	</cfloop>
<cfset benchmark.end() />

<!--- test block --->
<cfset benchmark.start("'=='-Operator","with string and integer") />
	<cfset a = 111 />
	<cfset b = "bbb" />
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfif a == b></cfif>
	</cfloop>
<cfset benchmark.end() />



<!--- Visualize --->
<cfset benchmark.writeFooter() />