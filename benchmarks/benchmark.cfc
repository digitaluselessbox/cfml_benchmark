/*
	Component: CFBenchmark
	Description: Time profiling "framework" for ColdFusion
	Thanks to: Eduard U. for the inspirations and the first steps
*/

component {
	// init
	public function init( struct config = {} ) 
		hint = "init function. Confiruge a benchmark object."
	{
		this.times = [];
		this.timesNames = [];
		this.timesDescription = [];
		this.timesResults = [];
		this.timeStart = 0;
		this.powerFactor = 1;

		/* arguments.config */
		if( NOT structKeyExists(arguments.config, 'maxIterations')){
			arguments.config.maxIterations = 1;
		}		
		if( NOT structKeyExists(arguments.config, 'testName')){
			arguments.config.testName = "unnamed Test";
		}
		if( NOT structKeyExists(arguments.config, 'testDescription')){
			arguments.config.testDescription = "";
		}
		if( NOT structKeyExists(arguments.config, 'chartWidth')){
			arguments.config.chartWidth = 700;
		}
		if( NOT structKeyExists(arguments.config, 'chartheight')){
			arguments.config.chartheight = 0; // 0: height is calculated by benchmark amounts
		}
		if( NOT structKeyExists(arguments.config, 'outputResults')){
			arguments.config.outputResults = true;
		}
		if( NOT structKeyExists(arguments.config, 'testData')){
			arguments.config.testData = "";
		}
		
		this.maxIterations = arguments.config.maxIterations * this.powerFactor;
		this.testName = arguments.config.testName;
		this.testData = arguments.config.testData;
		this.testDescription = arguments.config.testDescription;
		this.chartWidth = arguments.config.chartWidth;
		this.chartheight = arguments.config.chartheight;
		this.outputResults = arguments.config.outputResults;
		this.executionTime = now();

		/* Chartist Configuration */
		this.chartistOptions = {
			'width': this.chartWidth,
			'height': this.chartheight,
			'horizontalBars': true,
			'seriesBarDistance': 10,
			'horizontalBars': true,
			'showGridBackground': true,
			'axisX': {
				'onlyInteger': true
			},
			'axisY': {
				'offset': 150
			},
			'chartPadding': {
				'top': 15,
				'right': 35,
				'bottom': 25,
				'left': 10
			}
		};

		/* chartist plugins configuration */
		this.chartistPluginOptions = {
			'ctAxisTitle': {
				'axisX': {
					'axisTitle': 'Time in ms',
					'axisClass': 'ct-axis-title',
					'offset': {
						'x': 0,
						'y': 50
					},
					'textAnchor': 'middle'
				}		
			}
		};

		// init and append  benchmark history in session
		/* session.benchmark_history = {}; */
		if(not structKeyExists(session,"benchmark_history")){
			session.benchmark_history = {};
		}
		if(not structKeyExists(session.benchmark_history, this.testName)){
			session.benchmark_history[this.testName] = [];
		}
		arrayAppend(session.benchmark_history[this.testName], this);
	}
	

	remote function resetHistory( string historyName = "" )
		hint="this function supposed to be called via js/ajax to reset the history of a specific benchmark"
	{
		if(len(trim(arguments.historyName))){
			if(arguments.historyName EQ "all"){
				session.benchmark_history = {};
			}{
				if(structKeyExists(session.benchmark_history,arguments.historyName)){
					session.benchmark_history[arguments.historyName] = [];
				}
			}
		}
		return true;
	}
	
	
	public function start( string name, string description="" )
		hint = "call this function at the beginning of a code block you want to benchmark"
	{
		ArrayAppend( this.timesNames, arguments.name );
		ArrayAppend( this.timesDescription, arguments.description );
		this.timeStart = GetTickCount();
	}
	
	
	public function end( any testResult = {} ) 
		hint = "call this function at the end of a code block you want to benchmark"
	{
		var duration = GetTickCount() - this.timeStart;
		ArrayAppend(this.times, duration);
		ArrayAppend(this.timesResults, arguments.testResult);

		if(!this.chartheight){
			this.chartistOptions["height"] = 100 * arrayLen( this.times ) + 50;
		}

	}
	
	
	public function writeHeader() 
		hint = "write the header with html structur, js-library and css includes and the HTML page header"
	{
		writeOutput('
			<html>
				<head>
					<link rel="stylesheet" type="text/css" href="../css/benchmark.css" />
					<link rel="stylesheet" href="../css/chartist.css">
					<link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
					<link rel="stylesheet" href="../css/open-iconic-bootstrap.css">
					
					<script src="../js/jquery-3.5.1.min.js"></script>
					<script src="../js/chartist.js"></script>
					<script src="../js/chartist-plugin-axistitle.js"></script>
					<script src="../js/chartist-bar-labels.js"></script>
					<script src="../js/bootstrap/bootstrap.min.js"></script>
					<script src="../js/benchmark.js"></script>
				</head>');
				
				writeOutput('<body>');
				
				/* loading overlay */
				writeOutput('
					<div class="overlay"></div>
					<div class="spanner">
						<div class="loader"></div>
						<p class="loader_message">Resetting History for this benchmark.</p>
					</div>');
				
				/* page head with back button */
				writeOutput('
					<div class="previous_link">
						<a href="../index.cfm" titel="return to benchmark selection">
							<button type="button" class="btn btn-primary">
								<span class="oi oi-arrow-circle-left"></span>
								Benchmark List
							</button>
						</a>
					</div>');
				
				/* start test information with title, iterations and description */	
				writeOutput('
					<h1>
						#this.TestName#<br>
						<span class="subtitle">Iteration per test: #lsnumberformat(this.maxIterations)#</span>
					</h1>
					<div class="test_description">#this.testDescription#</div>');
		
		/* prepare and display testdate from benchmark config */
		if( 
			(isSimpleValue(this.testData) AND len(this.testData)) OR 
			(isArray(this.testData) and arrayLen(this.testData)) OR
			(isQuery(this.testData) and this.testData.recordcount LT 150) OR
			(isStruct(this.testData) and listLen(structKeyList(this.testData)))
		){
			savecontent variable="local.testdata" { writeDump(var = this.testData, expand = false) };

			writeoutput('
				<h2>Test Data</h2>
				<div class="test_data">
					#local.testdata#
				</div>
			');
		}
	}
	

	public function writeFooter() 
		hint = "write the test results into the html structure and includes a div
				container for the chart. finally it closes the html page and write
				the chart creation script to the htmlheader"
	{
		
		writeoutput('<h2>Benchmark Results</h2>');

		if(this.outputResults){
			writeOutput("
				<div class='benchmark_result_wrapper'>
					<div>&nbsp;</div>
					<div class='benchmark_results'>
						#writeResults()#
					</div>
					<div class='benchmark_charts'>
						<div class='benchmark-chart'></div>
					</div>
					<div>&nbsp;</div>
				</div>"
			);
		} else {
			writeOutput("<div class='benchmark-chart'></div>");
		}
		
		/* write JS to HTML-HEADER */
		savecontent variable="local.htmlHeadContent" {
			writeOutput("<script>");
			/* JS to setup chartist-js */
			writeOutput("
				window.onload = function() {
					var data = { 
						// A labels array that can contain any sort of values
						labels: #serializeJSON( this.timesNames )#,
						// Our series array that contains series objects or in this case series data arrays
						series: [ #serializeJSON( this.times )# ]
					};
					var options = #serializeJSON( this.chartistOptions )#;
					options.plugins = [ 
						Chartist.plugins.ctAxisTitle( #serializeJSON( this.chartistPluginOptions.ctAxisTitle )# ),
						Chartist.plugins.ctBarLabels({
							position: {
								x: function (data) {
									return data.x1 + 50
								}
							},
							labelOffset: {
								y: 7
							},
							labelInterpolationFnc: function (text) {
								return text + 'ms'
							}
						}) 
					];
					new Chartist.Bar('.benchmark-chart', data, options);
				};");

			writeOutput("</script>");
		}
		cfhtmlhead( text = local.htmlHeadContent );

		
		/* writeDump( session.benchmark_history[this.testName] );	 */
		
		writeoutput('<div>&nbsp;</div>');// empty dummy row

		writeoutput('<div class="history_wrapper" >');
			writeoutput('<div>&nbsp;</div>');// empty dummy grid item

			writeoutput('<div>');// history accordion
				writeoutput('<h3>History (#arrayLen(session.benchmark_history[this.testName])#)
					<a class="history_reset" href="##" onclick="resetHistory(''#this.testName#'')" title="reset history of this benchmark">
						<span class="oi oi-trash"></span>
					</a></h3>');
				writeoutput('<div class="accordion" id="benchmark_history_accordion">');
					
				for(j = arraylen(session.benchmark_history[this.testName]); j > 0; j = j - 1) {
					var arrayItem =  session.benchmark_history[this.testName][j];
					var arrayIndex = j;

					writeOutput('<div class="accordion-item">');
						writeOutput('<h2 class="accordion-header" id="heading#j#">');
							writeOutput('<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="##collapse#j#" aria-expanded="false" aria-controls="collapse#j#">');
								writeOutput('#lsdatetimeFormat(arrayItem.executiontime)#');
							writeOutput('</button>');
						writeOutput('</h2>');
						
						writeOutput('<div id="collapse#j#" class="accordion-collapse collapse" aria-labelledby="heading#j#" data-bs-parent="##benchmark_history_accordion">');
							writeOutput('<div class="accordion-body">');
							
								var resultTimes = "";
								var timesLen = ArrayLen( arrayItem.times );
								for(i = 1; i <= local.timesLen; i += 1) {
									savecontent variable="local.resultTimes" {
										writeOutput('<div class="card mb-3 benchmark_result">');
											writeOutput('<div class="card-body">');
												writeOutput('<h5 class="card-title">#arrayItem.timesNames[i]#</h5>');
												writeOutput('<div class="card-text">');
													/* benchmark time */
													writeOutput("
														<div class='time'>
															<strong>Time:</strong> " & 
															arrayItem.times[i] & "ms" &
														"</div>");
												writeOutput('</div>');
											writeOutput('</div>');
										writeOutput('</div>');
										writeOutput(local.resultTimes);
									}
								}			
								writeOutput(local.resultTimes);
							writeOutput('</div>'); // accordion body close
						writeOutput('</div>'); // accordion collaps wrapper
					writeOutput('</div>'); // accordion item close
				}
				writeoutput('</div>'); // accordion close
			writeoutput('</div>'); // wrapper close

			writeoutput('<div class="history_benchmark_summary" >');
				writeoutput('<h3>Average benchmark times 
					<a class="history_reset" href="##" onclick="doAnotherbenchmark()" title="do another run of this benchmark">
						<span class="oi oi-reload"></span>
					</a></h3>');
				writeoutput('<div>');
					if( arraylen(session.benchmark_history[this.testName]) ){
						// writedump(session.benchmark_history[this.testName][1]['timesNames']);
						averageTimes = [];

						for(j = 1; j <= arraylen(session.benchmark_history[this.testName][1]['timesNames']) ; j += 1) {
							for (var loopItem in session.benchmark_history[this.testName]) {
								averageTimes[j] = (averageTimes[j]?:0) + local.loopItem['times'][j];
							} 
						}

						for(j = 1; j <= arraylen(session.benchmark_history[this.testName][1]['timesNames']) ; j += 1) {
							averageTimes[j] = averageTimes[j] / arraylen(session.benchmark_history[this.testName]);
						}

						// writedump(averageTimes);
							var averageResultTimes = "";
							var timesLen = ArrayLen( arrayItem.times );
							for(i = 1; i <= local.timesLen; i += 1) {
								savecontent variable="local.averageResultTimes" {
									writeOutput('<div class="card mb-3 benchmark_result">');
										writeOutput('<div class="card-body">');
											writeOutput('<h5 class="card-title">#arrayItem.timesNames[i]#</h5>');
											writeOutput('<div class="card-text">');
												/* benchmark time */
												writeOutput("
													<div class='time'>
														<strong>Time:</strong> " & 
														int(averageTimes[i]) & "ms" &
													"</div>");
											writeOutput('</div>');
										writeOutput('</div>');
									writeOutput('</div>');
									writeOutput(local.averageResultTimes);
								}
							}			
							writeOutput(local.averageResultTimes);
						

					}
				writeoutput('</div>');
			writeoutput('</div>'); // history summary close
			writeoutput('<div>&nbsp;</div>');// empty dummy grid item
		writeoutput('</div>'); // history wrapper close
	}

	
	private function writeResults() 
		hint = "create the complete test results as html and returns it"
	{
		savecontent variable="local.result" {
			var timesLen = ArrayLen( this.times );
			for(i = 1; i <= local.timesLen; i += 1) {


				writeOutput('<div class="card mb-3 benchmark_result">');
					writeOutput('<div class="card-body">');
						writeOutput('<h5 class="card-title">#this.timesNames[i]#</h5>');
						writeOutput('<div class="card-text">');
							/* benchmark time */
							writeOutput("
								<div class='time'>
									<strong>Time:</strong> " & 
									this.times[i] & "ms" &
								"</div>");
							
							/* benchmark description */
							if(len(this.timesDescription[i])){
								writeOutput("
									<div class='description'>
										<strong>Description:</strong><br>" & 
										this.timesDescription[i] & 
									"</div>");
							}
							
							/* benchmark results */
							if( 
								(isSimpleValue(this.timesResults[i]) AND len(this.timesResults[i])) OR 
								(isArray(this.timesResults[i]) and arrayLen(this.timesResults[i])) OR
								(isQuery(this.timesResults[i]) and this.timesResults[i].recordcount LT 150) OR
								(isStruct(this.timesResults[i]) and listLen(structKeyList(this.timesResults[i])))
							){
								writeOutput("
									<div class='result'>
										<div><strong>Results:</strong></div>");
										writeOutput("<div>");		
											writeDump( var = this.timesResults[i], expand = false);
										writeOutput("</div>");	
								writeOutput("</div>");
							}
						writeOutput('</div>');
					writeOutput('</div>');
				writeOutput('</div>');
			}
		}	
		return local.result;
	}


	private function benchmarkdump(any var, boolean append = true) 
		hint = "dump function. creates a debug.html file in the folder of the benchmark component. 
			    debug content can be apended to or overwrite existing content"
	{
		savecontent variable="local.debugText" {
			writeOutput("
				<div style='background-color: ##eee; color: black; border: 1px solid ##ccc; padding: 5px;'>
				#TimeFormat(Now(), 'HH:mm:ss')#
				</div>
				<div style='border: 1px solid ##ccc; border-top: none; padding: 5px; margin-bottom: 16px;'>");				
			writeDump(arguments.var);
			writeOutput("</div>");
        };
		
		if(arguments.append){
			var debugFile = FileOpen(expandPath("debug.html"), "append");
			FileWrite(local.debugFile, local.debugText);
			FileClose(local.debugFile);
		} else {
			fileWrite(expandPath("debug.html"), local.debugText);
		}
	}
}
