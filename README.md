# ColdFusion Benchmark  <!-- omit in toc -->

- [Description](#description)
- [Features](#features)
- [ColdFusion Benchmark Component](#coldfusion-benchmark-component)
- [Benchmark File](#benchmark-file)
	- [Benchmark config and initialisation](#benchmark-config-and-initialisation)
	- [Benchmark test blocks](#benchmark-test-blocks)
	- [Benchmark display results](#benchmark-display-results)
- [Getting started](#getting-started)
	- [Setup](#setup)
	- [Compatibility](#compatibility)
	- [My first benchmark](#my-first-benchmark)
- [ColdFusion Benchmark Configuration](#coldfusion-benchmark-configuration)
	- [Component Configuration](#component-configuration)
	- [Benchmark Configuration](#benchmark-configuration)
- [Scaffolding](#scaffolding)
- [example images](#example-images)
- [Credits](#credits)

## Description

This ColdFusion(CF) compoment should provide a simple way to compare the execution
speed of different code snippets.

CF allways has diffenrent ways to solve a problem. A simple example is
the "is equal" operator. In CF you have many different operators for this
little task: "EQ","IS" and for several years "==" is also available. In the 
past years of my ColdFusion developer life I always ask myself which one is the 
fastest way to do things in CF.

With this component you have the possibility to create little test blocks, where
you can run your code snippets in an loop with a defined iteration. The component
messure the time it take to finish a testblock. After all test blocks in a
benchmark finished the component display the time of each testblock in a nice
chart. 

## Features

- very nice benchmark display
  - colorfull charts for the benchmark results
  - can display all information for the benchmark an the test blocks
  - can shows test and result data
- many predefined benchmarks
- many configuration possibilities
  - power factor to fit benchmark to your system
  - benchmark name
  - testblock iteration
  - benchmark desacription
  - testblock description
  - chart size and colors
  - testblock name and description
  - etc...
- session based benchmark history
- benchmark average times
- Adobe CF 2021 and Lucee 5.3.7.48 compatible
- Bootstrap 5 
- easy to extend and use for your own benchmarks


## Version

1.0.0


## ColdFusion Benchmark Component 

The basic idea is, the benchmarks should only consists of a basic benchmark
configuration and the test blocks. The benchmarkl creator should not have any trouble with HTML or the display of the benchmark results.

How does it work? The component has 4 main methods, it has a method to write the benchmark header, a start and an end method for the test blocks and also a method to display all results and fisnish the benchmark page.  

```
- init()
- writeHeader()
- Benchmark-Block
	- start(name)
	- end(result)
- writeFooter()
```

## Benchmark File

As mentioned in the ColdFusion Benchmark component description there is no html stuff
inside the benchmark file. The benchmark files consists of x parts. 


### Benchmark config and initialisation

Inside the first cfscript-block you will find the benchmark configuration, depends
on your needs, the ColdFusion Benchmark initialisation and the page header creation with
the writeHeader() method. For detail configuration information see the
[configuration section](#coldfusion-benchmark-configuration).

### Benchmark test blocks

You can have as many test blocks you like there is no restrictions except the server timeout. ;)

The test blocks are not nestable. Therefor a testblock must at least have a start() method and an end() method. Between both methods you could have your code
snippet. 

Often one execution of a snippet only take blink of time to eaven a millisecond.
Therefor you maybe want to sourround your snippet with a from-to loop that uses the
maxIterations variable as to-parameter. 

**Example TestBlock:**

```ColdFusion
<cfscript>
	benchmark.start("Example - Name", "Example - Description");

	for(i = 1; i lte benchmark.maxIterations; i += 1) {
		//***************************
		// INSERT YOUR CODE SNIPPET HERE
		//***************************
		result = 1;
	}
	
	benchmark.end( result );
</cfscript>
```

### Benchmark display results

Last but not least after ending your last testblock we need to display the 
benchmark results. with the writeFooter() method.

```ColdFusion
<cfscript>
	benchmark.writeFooter();
</cfscript>
```


## Getting started

### Setup

The setup can look very different. In the first place you need a ColdFusion 
server and a web server. The buildin web server of the common ColdFusion
application servers is completely sufficient.

ColdFusion-Benchmark uses sessions, therefor session management must be 
enabled from the server side.

To put the repository into your root folder is the simplest way to go.


### Compatibility

ColdFusion-Benchmark has already been tested under the following conditions:

- Docker environment with the image: **ortussolutions/commandbox:latest**. With the Lucee CF-Engine version **5.3.7.48**
- Also testet with a stand alone **CommandBox 4.4** installation and the following CF-Engines
  - **lucee 5.2.9+31**
  - **Adobe CF 2021.0.1**

### My first benchmark

You can find a sample benchmark file at **"/benchmarks/benchmark.example"**. 

To create your first own benchmark just copy that file to ***mybenchmarkname.cfm***
in the same folder. After reloading the benchmarks overview you will see a new
button **mybenchmarkname**. Click on it and see the results of your first
benchmark!

Now you can go on and configure your benchmark in more detail. To get a better
feel you can also take a look at the allready existing benchmarks.

## ColdFusion Benchmark Configuration

There are two configuration possibilities in ColdFusion Benchmark. The first possibility
is in the component itself. 
The component configuration is some kind of global configuration for all 
benchmarks. 

### Component Configuration

There are not many configurations, but there are some. You can configure the 
powerFactor, chartist js library and default values of the optional benchmark parameters.

#### powerFactor 

It is a factor that multiplies with the maxIteration value. So you can change the amount of testcycles inside a testblock. 

All test blocks are adjusted to the max of ca. 1000ms. But if your system has less power and the Test took 5000ms or more, you can half the test cycles by setting the power factor to "0.5". You can also double the testcycles by setting the powerfactor to "2".

#### chartist js library
See the [chartist configuration docs](https://gionkunz.github.io/chartist-js/api-documentation.html) for information about the settings.

#### default values

There are default values for all possible benchmark configuration parameters. 
You can change these values if you want a global default config for the
benchmarks that better fits to your personal needs.

See the benchmark configuration for more details about each parameter.

### Benchmark Configuration

Default benchmark configuration. Also match with the global default values in the
ColdFusion Benchmark component.

```js
benchmark_config = {
	testName = "unnamed Test",
	testDescription = "",
	testData = "",
	maxIterations = 1,
	chartwidth = 700,
	chartheight = 0,
	outputResults = true
};
```

#### testName
Name of the benchmark. It will be shown on the result page.

#### testDescription

Exact description of the benchmark. This will be shown in the results page.

#### testData

Here you can add the test data with which the benchmark is performed.
The content is displayed as a "Dump". Can be an array, struct or string.

#### maxIterations
Number of runs within a test block

You have to execute a code snippet many times under most circumstances, to get
a measurable time. An 'if'-statement  with an isnumeric() function is done so
fast that only after repeating it 1Mio. times a measurable time is available. 

This depends of course also on the computing power of the computer on which 
the benchmark is executed. See [powerFactor](#powerfactor) setting.

#### chartwidth
The width of the chart that visualizes the measured times of the benchmark blocks.

#### chartheight
The height of the chart that visualizes the measured times of the benchmark blocks.

- **0 =** the height of the chart is determined automatically.

#### outputResults

Each test block has the possibility to display results of the test block
in the subsequent visualization. This setting can be used to activate or
deactivate the possibility in gerneral.

## Scaffolding

### js

- jquery (v3.5.1)
- chartist (v0.11.4)
- bootstrap (v5.0.2)

### css

- benchmark.css (custom css)
- bootstrap (v5.0.2)
- chartist (v0.11.4)
- open-iconic-bootstrap.css

### font
- open-iconic font stuff

### benchmarks

- the benchmark component
- benchmarks itself

### readme

- image files for the readme


## example images
*Benchmark Overview*
![Benchmark Overview](/readme/benchmark_list.png)

*Benchmark Details*
![Array To List](/readme/array_to_list.png)

*Benchmark History*
![Array To List](/readme/array_to_list_history.png)


## Credits

Thanks goes to Eduard U. for the first benchmark component which was the mother of this project.


