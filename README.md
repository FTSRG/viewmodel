# ViewModel

*ViewModel* is a view transformation approach with (1) a fully compositional transformation language built on top of the [VIATRA Query language](https://www.eclipse.org/viatra/documentation/query-language.html), and (2) a transformation engine which is reactive, incremental, validating and inconsistency-tolerant at the same time. For more information see the [publication page](https://github.com/FTSRG/publication-pages/wiki/Incremental-View-Model-Synchronization-Using-Partial-Models) of our recently submitted paper.

## Users' Guide

### Creating and running view transformations

*ViewModel* is available as an Eclipse plugin from our update site (go to *Help > Install New Software...* in Eclipse and enter the following URI):

    http://docs.inf.mit.bme.hu/viewmodel/repository

The *ViewModel Runtime* feature is required for executing transformations, while the *ViewModel SDK* feature contains editor support and code generator for the transformation language. See the [implementation of the benchmarks](https://github.com/FTSRG/viewmodel/tree/master/benchmarks/plugins/hu.bme.mit.inf.viewmodel.benchmarks.viewmodel/src/hu/bme/mit/inf/viewmodel/benchmarks/viewmodel) for usage.

View specification classes are generated from `.viewmodel` files, which should be located in the source folder of an Eclipse plug-in project.
The bundle `hu.bme.mit.inf.viewmodel.runtime.transformation` should be added to the set of plug-in dependencies.
The helper class `hu.bme.mit.inf.viewmodel.runtime.transformation.ViewModel` provides easy execution of transformations:

    // MyGeneratedView is the view specification class generated from MyGeneratedView.viewmodel
    val viewModel = ViewModel.create(resource, MyGeneratedView.createSpecification)
    viewModel.startUnscheduledExecution
    val results = viewModel.results
    // Modify `resource` here to get `results` updated automaticaly.
    viewModel.dispose

As there is currently no support for running from a plain JAR / Maven application, an Eclipse application or plug-in test should be used.

The ViewModel plugin and its benchmarks were build and tested with Java 1.8.0. It may be possible to develop or run them with Java 9 or 10, however, we recommend Java 1.8.0 instead. 

### Running the benchmarks

A set of benchmarks were prepared for ViewModel and imperative reactive VIATRA transformations. Our results are available at the [publication page](https://github.com/FTSRG/publication-pages/wiki/Incremental-View-Model-Synchronization-Using-Partial-Models).

The benchmarks are packaged as an Eclipse application (see the instructions below for building).

  * `linux gtk x86_64`: https://www.dropbox.com/s/ylac7r4iyv0gd01/hu.bme.mit.inf.viewmodel.benchmarks.product-linux.gtk.x86_64.zip?dl=1
  * `macosx cocoa x86_64`: https://www.dropbox.com/s/cd81j7w23yhgxyb/hu.bme.mit.inf.viewmodel.benchmarks.product-macosx.cocoa.x86_64.zip?dl=1
  * `win32 win32 x86_64`: https://www.dropbox.com/s/vem1xi5a6xp5yyf/hu.bme.mit.inf.viewmodel.benchmarks.product-win32.win32.x86_64.zip?dl=1

The archives contain the Eclipse application, example models, and `.json` configuration files for various transformation cases and model modification mixes. Execute the benchmark with

    ./eclipse -benchmarks <CONFIGURATION FILE>.json -vmargs -Xmx15g

By default, the benchmark configurations `d_batch.json`, `d_NN.json` (`NN` = `01`..`15`), `vs_batch.json` and `d_NN.json` will output benchmarks results to `/mnt/results`. This enables mounting a shared filesystem at that path to collects logs from multiple machines.

For running the benchmarks in Amazon EC2 (we used `m5.xlarge` instances with Amazon Linux AMI 2017.09.1), some utility scripts are provided in `/benchmarks/scripts` which aid in setting up the measurement environment.

For trying out the benchmarking environment in a more limited environment, you can use the `short.json` configuration, which does not depend on a mounted shared filesystem, and runs only a few experiments.

The R Markdown files `benchmarks/R/viewmodel-data-analysis/viewmodel-data-analysis-results.Rmd` and `benchmarks/R/viewmodel-data-analysis/viewmodel-data-analysis-results-short.Rmd` may be knitted to generate reports from the `full_log.csv` and `short_log.csv` files, respectively. They were tested under R 3.5.0 and RStudio 1.1.453 (Arch Linux), as well as R 3.4.4 and RStudio 1.1.442 (Ubuntu 18.04) with tidyverse 1.2.1 and knitr 1.20.

## Developers' Guide

### Cloning the repository

The *ViewModel* benchmarks contain several large example models taken from the [Train Benchmark](https://github.com/FTSRG/trainbenchmark), which were modified for compatiblity with some tools used in the benchmark, such as [eMoflon](https://emoflon.org/). Hence these models were added to the repository. Unfortunately, their size neccessitated the use of [Git LFS](https://git-lfs.github.com/) (Large File Storage).

To clone the repository with large files, first [install Git LFS](https://git-lfs.github.com/) to get started. Then you can clone the repository with the command

    git lfs clone https://github.com/FTSRG/viewmodel

If you do not need the example models, simply cloning with `git clone` will also suffice.

### Building the project

This project uses [Eclipse Tycho](https://www.eclipse.org/tycho/) to automate compilation and packaging.

Build the project from scratch using the command

    mvn clean package

Upon successful build, a p2 update site is output to `/releng/hu.bme.mit.inf.viewmodel.repository/target/repository`.

Later, you may pass the options `-DskipViatraGenerator` and `-DskipXtextGenerator` to skip generating rarely changing artifacts from scratch (don't forget to run the generator when appropriate!).

To also build the benchmarking Eclipse application, use

    mvn clean package -DcompileBenchmarks

instead. This may take significantly longer due to the increased number of dependencies. Upon successful build, product archives are output to `/benchmarks/releng/hu.bme.mit.inf.viewmodel.benchmarks.repository/target/products`.

### Developing with Eclipse

To develop *ViewModel* with Eclipse (version Oxygen.2 recommended), you should first install the following Eclipse plugins:

  * [Xtext SDK](https://www.eclipse.org/Xtext/download.html) 2.13.0
  * [VIATRA Query and Transformation SDK](https://www.eclipse.org/viatra/downloads.html) 1.7.2

After installing the required plugins, the Eclipse projects inside the repository (except the projects in the `benchmarks/`) folder can be imported into Eclipse.

You should set `hu.bme.mit.inf.viewmodel.target` as the target platform to build *ViewModel* and start a runtime Eclipse instance to develop your view transformations.

To develop and run the benchmarks, additional preparation is needed. First make sure to import the projects

  * hu.bme.mit.inf.viewmodel.benchmarks.target
  * hu.bme.mit.inf.viewmodel.benchmarks.models

into your host Eclipse. Set `hu.bme.mit.inf.viewmodel.benchmarks.target` as the target platform, which will also provision via p2 some additional transformations tools for use in the benchmarks. Start a runtime Eclipse instance and import the rest of the projects from the `benchmarks/` directory. The benchmarks application `hu.bme.mit.inf.viewmodel.benchmarks.application.ViewModelBenchmarks` an be executed from within Eclipse (as an Eclipse application run configuration). Do not forget to set the working directory and pass command line arguments to the run configuration as needed.

## License

The project uses the Eclipse Public License 1.0. For more information see [NOTICE.md](https://github.com/FTSRG/viewmodel/blob/master/NOTICE.md) and [CONTRIBUTORS.md](https://github.com/FTSRG/viewmodel/blob/master/CONTRIBUTORS.md).

## Acknowledgment

The project was partially supported by the [MTA-BME Lendület Cyber-Physical Systems Research Group](http://lendulet.inf.mit.bme.hu/) and the [Fault Tolerant Systems Research Group](https://inf.mit.bme.hu/en) of the Department of Measurement and Information Systems, Budapest University of Technology and Economics.

