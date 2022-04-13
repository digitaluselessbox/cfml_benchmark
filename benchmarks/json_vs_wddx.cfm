
<cfscript>
	benchmark_config = {
		testName = "JSON vs. WDDX",
		testDescription = "test speed of json vs. wddx",
		maxIterations = 2000,
		testData = '[{"_id":"5f270e1e9823ac66e7c466b5","index":0,"guid":"07472cc4-138f-4292-a65e-a5e7e1b9f840","isActive":false,"balance":"$3,572.56","picture":"http://placehold.it/32x32","age":39,"eyeColor":"green","name":"Savannah Payne","gender":"female","company":"ZIZZLE","email":"savannahpayne@zizzle.com","phone":"+1 (992) 547-2729","address":"132 Dupont Street, Wolcott, Washington, 1467","about":"Cillum nostrud tempor consectetur aliquip dolore nostrud laborum ad. Enim reprehenderit consectetur esse qui deserunt pariatur id nulla magna enim officia ea dolor. Reprehenderit esse fugiat mollit laboris reprehenderit consequat voluptate. Cupidatat et quis irure pariatur ullamco aute sit eiusmod ex ullamco ullamco labore amet aute. Officia irure ullamco Lorem cillum nisi ad sint consequat aliquip. Laboris minim eiusmod proident aliqua dolor minim nulla adipisicing pariatur sint deserunt. Consectetur quis tempor velit et commodo ullamco.\r\n","registered":"2017-05-09T09:26:51 -02:00","latitude":30.319505,"longitude":-50.607646,"tags":["ullamco","fugiat","qui","Lorem","nulla","veniam","ut"],"friends":[{"id":0,"name":"Santos Hodges"},{"id":1,"name":"Patrick Fox"},{"id":2,"name":"Carmela Hart"}],"greeting":"Hello, Savannah Payne! You have 7 unread messages.","favoriteFruit":"apple"},{"_id":"5f270e1ed527b78dd4a18636","index":1,"guid":"47de9bef-00e8-421e-b3e2-05089fde4deb","isActive":false,"balance":"$3,535.09","picture":"http://placehold.it/32x32","age":25,"eyeColor":"brown","name":"Cleo Clay","gender":"female","company":"XIXAN","email":"cleoclay@xixan.com","phone":"+1 (969) 462-2967","address":"761 Wogan Terrace, Groveville, Idaho, 6706","about":"Exercitation labore officia et eiusmod ipsum aliqua pariatur cupidatat dolore ad aute quis esse ex. Quis dolore esse irure nulla non dolor. Ipsum irure ullamco laborum ipsum dolore tempor occaecat excepteur id. Excepteur in elit excepteur commodo culpa eu do exercitation ea Lorem ea. In ex reprehenderit velit eu esse laboris occaecat duis. Consectetur ullamco exercitation ad ipsum irure ullamco ad id nisi. Laboris enim eiusmod pariatur dolore voluptate cupidatat reprehenderit laboris excepteur magna tempor ipsum cupidatat et.\r\n","registered":"2018-10-18T11:57:12 -02:00","latitude":80.238823,"longitude":-87.405166,"tags":["culpa","occaecat","eiusmod","nisi","laborum","quis","consequat"],"friends":[{"id":0,"name":"Montgomery Whitehead"},{"id":1,"name":"Robin Barlow"},{"id":2,"name":"Guerrero Doyle"}],"greeting":"Hello, Cleo Clay! You have 6 unread messages.","favoriteFruit":"apple"},{"_id":"5f270e1e5b3978b3e3e4e4ec","index":2,"guid":"98f299e1-2e9a-46e8-9dad-b55ec64141fc","isActive":true,"balance":"$2,612.17","picture":"http://placehold.it/32x32","age":34,"eyeColor":"brown","name":"Wheeler Nunez","gender":"male","company":"NIXELT","email":"wheelernunez@nixelt.com","phone":"+1 (890) 578-2884","address":"995 Noble Street, Winesburg, Ohio, 5648","about":"Veniam sit quis culpa incididunt quis duis ad ut deserunt labore anim in velit. Cupidatat laborum incididunt deserunt et. Sint adipisicing elit laborum culpa fugiat. Duis nostrud nisi esse nulla aliquip pariatur dolor adipisicing reprehenderit qui consectetur. Aute officia amet esse laborum labore occaecat enim aliqua et nostrud sunt voluptate tempor. Officia esse id sunt non proident. Reprehenderit aliquip velit ipsum mollit cupidatat dolor.\r\n","registered":"2015-03-26T01:14:05 -01:00","latitude":-22.33481,"longitude":-0.044581,"tags":["mollit","occaecat","Lorem","consequat","voluptate","dolore","officia"],"friends":[{"id":0,"name":"Ryan Berg"},{"id":1,"name":"Jackie Puckett"},{"id":2,"name":"Hensley Mccormick"}],"greeting":"Hello, Wheeler Nunez! You have 3 unread messages.","favoriteFruit":"apple"},{"_id":"5f270e1e89300908a2b0f968","index":3,"guid":"5bf70ca8-0963-4ab8-a03c-ce70efd19e02","isActive":true,"balance":"$3,076.89","picture":"http://placehold.it/32x32","age":38,"eyeColor":"blue","name":"Ana Glass","gender":"female","company":"ISOLOGICS","email":"anaglass@isologics.com","phone":"+1 (909) 512-3557","address":"427 Gain Court, Tolu, Pennsylvania, 9746","about":"Pariatur velit ullamco officia aliquip amet duis ipsum proident consectetur esse. Fugiat laboris amet irure velit pariatur excepteur. Ullamco dolore id consequat amet pariatur proident. Consectetur consectetur velit adipisicing sit. Lorem consectetur voluptate laborum occaecat aliquip proident dolor veniam reprehenderit do pariatur.\r\n","registered":"2018-10-19T11:04:59 -02:00","latitude":-52.164132,"longitude":-169.019401,"tags":["culpa","ullamco","ullamco","in","sunt","ut","et"],"friends":[{"id":0,"name":"Marta Chaney"},{"id":1,"name":"Eleanor Hunter"},{"id":2,"name":"Wooten Griffith"}],"greeting":"Hello, Ana Glass! You have 6 unread messages.","favoriteFruit":"apple"},{"_id":"5f270e1e0e1d39e92532c4eb","index":4,"guid":"18e432fc-f190-43e7-9bf3-f75ee111b790","isActive":false,"balance":"$3,616.96","picture":"http://placehold.it/32x32","age":20,"eyeColor":"green","name":"Linda Gray","gender":"female","company":"ATOMICA","email":"lindagray@atomica.com","phone":"+1 (910) 432-3018","address":"324 Metropolitan Avenue, Fairhaven, New Hampshire, 4792","about":"Deserunt adipisicing sunt id sint duis quis. Ipsum officia id ullamco ut aute est. Elit adipisicing irure minim dolor est. Irure reprehenderit anim aliqua nisi duis tempor amet. Officia ea laborum ipsum cupidatat. Cupidatat ad commodo anim officia. Labore ut aute reprehenderit sint ea in ex magna dolore esse voluptate.\r\n","registered":"2016-11-30T02:06:56 -01:00","latitude":-64.667896,"longitude":-102.320765,"tags":["et","incididunt","anim","eu","id","sit","id"],"friends":[{"id":0,"name":"Gillespie Romero"},{"id":1,"name":"Rosie Moreno"},{"id":2,"name":"Murray Cameron"}],"greeting":"Hello, Linda Gray! You have 10 unread messages.","favoriteFruit":"apple"}]'
	};	

	deserializedTestData = deserializeJSON( benchmark_config.testData );
	
	benchmark = new benchmark( config = benchmark_config );  // init benchmark component
	benchmark.writeHeader();
</cfscript>


<!--- ######## JSON TEST ######## --->
<!--- TestBlock --->
<cfscript>
	benchmark.start("JSON: deserializeJSON()");
	
	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		deserializeJSON( benchmark.testData );
	}
	
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("JSON: serializeJSON()");
	
	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		serializeJSON(deserializedTestData);
	}
	
	benchmark.end();
</cfscript>


<!--- ######## WDDX TEST ######## --->
<!--- TestBlock --->
<cfscript>
	benchmark.start("WDDX: cfml2wddx (cfwddx)");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfwddx action = "cfml2wddx" input = "#deserializedTestData#" output = "tmp">
	</cfloop>
<cfscript>
	benchmark.end();
</cfscript>

<!--- TestBlock --->
<cfscript>
	benchmark.start("WDDX: wddx2cfml (cfwddx)");
</cfscript>
	<cfloop index="i" from="1" to="#benchmark.maxIterations#">
		<cfwddx action = "wddx2cfml" input = "#tmp#" output = "tmp2">
	</cfloop>
<cfscript>
	benchmark.end();
</cfscript>


<!--- Visualize --->
<cfset benchmark.writeFooter() />