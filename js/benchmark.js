
// function to display loading overlay, call ajax function resetHistory() and reload page to run a new benchmark
function resetHistory( benchmarkName, path = "" ){
	
	// display loading overlay
	$('div.spanner').addClass('show');
	$('div.overlay').addClass('show');
	$('p.loader_message').text('Resetting history for "' + benchmarkName + '" benchmark.');
			
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

// function to display loading overlay and reload page to run another benchmark
function doAnotherbenchmark(){
	// display loading overlay
	$('div.spanner').addClass('show');
	$('div.overlay').addClass('show');
	$('p.loader_message').text('Running benchmark.');

	document.location.reload();
}

