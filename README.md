## Docker containers for Bioconductor

Our aim is to provide up-to-date containers for the current 
release and devel versions of Bioconductor, and (probably, eventually)
some older versions.

For each supported version of Bioconductor, we provide several
images:


* *base*: Contains R and a single Bioconductor package (`BiocInstaller`,
  providing the `biocLite()` function for installing additional
  packages).
  Also contains many system dependencies for Bioconductor packages.
  Useful when you want a relatively blank slate for testing purposes. 
  R is accessible via the command line or via RStudio Server.
  The release and devel versions of these containers (and the
  containers built from them, below) are rebuilt
  daily with the latest versions of R-release or R-devel.
* *core*: Built on *base*, so it contains everything in *base*, plus
  a selection of core Bioconductor packages.
  See [the full list](#the-full-list)
* *microarray*: everything in *core*, plus 
  all packages tagged with the 
  [Microarray](/packages/release/BiocViews.html#___Microarray) biocView.
* *flow* everything in *core*, plus all packages tagged with the
  [FlowCytometry](/packages/release/BiocViews.html#___FlowCytometry) biocView.
* *proteomics* everything in *core*, plus all packages tagged with the
  [Proteomics](/packages/release/BiocViews.html#___Proteomics) biocView.
* *sequencing* everything in *core*, plus all packages tagged with the
  [Sequencing](/packages/release/BiocViews.html#___Sequencing) biocView.

## List of Containers

At present, the following containers are available:

* bioconductor/devel_base
* bioconductor/devel_core
* bioconductor/devel_flow
* bioconductor/devel_microarray
* bioconductor/devel_proteomics
* bioconductor/devel_sequencing
* bioconductor/release_base
* bioconductor/release_core
* bioconductor/release_flow
* bioconductor/release_microarray
* bioconductor/release_proteomics
* bioconductor/release_sequencing

## Using the containers

The following examples use the `bioconductor/devel_base` container.
Note that you may need to prepend `sudo` to all `docker` commands.

##### To run RStudio Server:

    docker run -p 8787:8787 bioconductor/devel_base

You can then open a web browser pointing to your docker host on port 8787.
If you're on Linux and using default settings, the docker host is
`127.0.0.1` (or `localhost`, so the full URL to RStudio would be
`http://localhost:8787)`. If you are on Mac or Windows and running
`boot2docker`, you can determine the docker host with the
`boot2docker ip` command.

Log in to RStudio with the username `rstudio` and password `rstudio`.

##### To run R from the command line:

    docker run -ti bioconductor/devel_base R

##### To open a Bash shell on the container:

    docker run -ti bioconductor/devel_base bash

*Note*: The `docker run` command is very powerful and versatile. 
For full documentation, type `docker run --help` or visit
the [help page](https://docs.docker.com/reference/run/).

<a name="the-full-list"></a>
## List of packages installed on the *core* container

* AnnotationDbi
* AnnotationHub
* Biobase
* BiocParallel
* biocViews
* biomaRt
* Biostrings
* BSgenome
* epivizr
* GenomicFeatures
* GenomicRanges
* graph
* Gviz
* httr
* IRanges
* knitr
* RBGL
* RCurl
* ReportingTools
* Rgraphviz
* rmarkdown
* XML
* zlibbioc

