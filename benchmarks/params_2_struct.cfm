<cfscript>
	benchmark_config = {
		testName = "convert url query string to CFML struct",
		testDescription = "",
		maxIterations = 50000,
		testData = "a=5&b=789&c=123&d=678&abacadsf=45"		
	};	

	benchmark = new benchmark( config = benchmark_config );
	benchmark.writeHeader();
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Version 1","works with list-functions like listfind,listfirst,listlast,etc...");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			data = structNew();
			params = benchmark.testData;
			paramLen = len(params);
			
			if(paramLen) {
				start = 1;
				pos = 1;
				
				while(pos neq 0) {
					pos = find('&', params, start); //find first occurrence of & from the given start point
					
					if(pos neq 0) { //found next & symbol
						// If the first character is "&" it should be removed and the loop needs to be restarted
						if(pos == 1) {
							params = mid(params, 2, paramLen - 1);
							paramLen -= 1;
							continue;
						}
						
						str = mid(params, start, pos - start); //create paremeter str
					} else { // there is no more & symbol
						str = mid(params, start, paramLen - start + 1); //create paremeter str
					}
					
					//set parameter into data struct
					if(listlen(str, '=') GT 1) {
						firstToken = listfirst(str, '=');
						lastToken = listlast(str, '=');
						
						if(isdefined("data.#firstToken#")){
							tmplist = evaluate("data.#firstToken#");
							"data.#firstToken#" = listappend(tmplist, lastToken); // add a parameter value with the same name (Example: networking keywords at news module)
						} else {
							"data.#firstToken#" = lastToken; // create parameter value in data
						}
					} else {
						"data.#listfirst(str, '=')#" = ""; // parameter has no value
					}
					
					start = pos + 1;
					
					if(pos EQ paramLen)
						pos = 0; // the last found & symbol is the last character. there is no more parameter and the loop must end
				}
			}
		}
	</cfscript>
<cfscript>
	benchmark.end( data );
</cfscript>


<!--- TestBlock --->
<cfscript>
	benchmark.start("Version 2","works with somekind of string slicing. It uses find(), mid(), left()");
</cfscript>
	<cfscript>
		for(i = 1; i lte benchmark.maxIterations; i += 1) {
			data = structNew();
			params = benchmark.testData;
			
			if(len(params) == 0) {
				return data;
			}
			
			posOuterConnector = 1;
			
			while(1) {
				posOuterConnector = find("&", params);
				posInnerConnector = find("=", params);
				
				// First character is the outer connector -> remove it and continue
				if(posOuterConnector == 1) {
					params = mid(params, 2, len(params) - 1);
					continue;
				}
				
				// Outer connector not found -> cancel loop
				if(posOuterConnector == 0) {
					if(posInnerConnector == 0) {
						if(len(params)) {
							"data.#params#" = "";
						}
					} else {
						key = left(params, posInnerConnector - 1);
						"data.#key#" = mid(params, posInnerConnector + 1, len(params) - posInnerConnector);
					}
					
					break;
				} else {
					if(posInnerConnector == 0) {
						key = left(params, posOuterConnector - 1);
						"data.#key#" = "";
					} else {
						if(posOuterConnector > posInnerConnector) {
							key = left(params, posInnerConnector - 1);
							"data.#key#" = mid(params, posInnerConnector + 1, posOuterConnector - posInnerConnector - 1);
						} else {
							key = left(params, posOuterConnector - 1);
							"data.#key#" = "";
						}
					}
					
					params = mid(params, posOuterConnector + 1, len(params) - posOuterConnector);
				}
			}
		}
	</cfscript>
<cfscript>
	benchmark.end( data );
</cfscript>

<!--- Visualize --->
<cfscript>
	benchmark.writeFooter();
</cfscript>