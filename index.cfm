<cfoutput>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="css/benchmark.css" />
		<link rel="stylesheet" href="css/chartist.css">
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<script src="js/jquery-3.5.1.min.js"></script>
		<script src="js/chartist.js"></script>
		<script src="js/chartist-plugin-axistitle.js"></script>
		<script src="js/chartist-bar-labels.js"></script>
		<script src="js/bootstrap/bootstrap.min.js"></script>
		<script src="js/benchmark.js"></script>
	</head>
	<body>
		<div class="overlay"></div>
		<div class="spanner">
			<div class="loader"></div>
			<p class="loader_message">Resetting History for this benchmark.</p>
		</div>

		<!--- Pfad anpassen --->
		<cfdirectory directory="#expandPath(application.benchmark_folder)#" name="variables.dirQuery" action="LIST" filter="*.cfm">
		
		<h1>ColdFusion Benchmarks</h1>
		<div class="container">
			<div class="row mb-3">
				<cfloop query="variables.dirQuery">
					<div class="col">
						<a 
							title="start benchmark for #listFirst(variables.dirQuery.name,'.')#" 
							href="##"
							onclick="doBenchmark('#application.benchmark_folder##variables.dirQuery.name#')" 
							class="btn btn-primary btn-lg d-grid" 
							role="button">
							#listFirst(variables.dirQuery.name,'.')#
						</a>
					</div>
					<cfif NOT variables.dirQuery.currentRow mod 3>
						</div>
						<div class="row mb-3">
					</cfif>					
				</cfloop>
			</div>
			<div>
				<a 
					title="Reset ALL Benchmark History" 
					href="##" 
					onclick="resetHistory('all','benchmarks/')"
					class="btn btn-danger btn-lg d-grid" 
					role="button">
					Reset ALL Benchmark History
				</a>
			</div>
		</div>
	</body>
</html>
</cfoutput>
