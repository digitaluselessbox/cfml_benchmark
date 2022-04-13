// function to display loading overlay
function displayLoadingOverlay(loader_message){
	// display loading overlay
	$('div.spanner').addClass('show');
	$('div.overlay').addClass('show');
	$('p.loader_message').text(loader_message);
}

// call ajax function resetHistory() and reload page to run a new benchmark
function resetHistory( benchmarkName, path = "" ){
	
	// display loading overlay
	displayLoadingOverlay('Resetting history for "' + benchmarkName + '" benchmark.');			
			
	setTimeout(
		function(){ 
			$.ajax({
				url: path + 'benchmark.cfc?method=resetHistory&returnFormat=json',
				method: 'GET',
				dataType: 'json',
				data: {
					'historyName': benchmarkName
				},
				success: function(){
					document.location.reload();
				}
			})
		}, 
		benchmarkName=="all" ? 3000 : 0
	)
}

// function to reload page to run another benchmark
function doAnotherbenchmark(){
	displayLoadingOverlay('Running benchmark.'); // display loading overlay
	document.location.reload();
}

// function to load page to run a benchmark
function doBenchmark(benchmarkURL){
	displayLoadingOverlay('Running benchmark.'); // display loading overlay
	document.location.href = benchmarkURL;
}
