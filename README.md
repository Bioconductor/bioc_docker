# Docker containers for Bioconductor

Our aim is to provide up-to-date containers for the current 
release and devel versions of Bioconductor, and (probably, eventually)
some older versions.

For each supported version of Bioconductor, we provide three
flavors:

* *small*: Contains R and a single Bioconductor package (`BiocInstaller`,
  providing the `biocLite()` function for installing additional
  packages).
  Also contains many system dependencies for Bioconductor packages.
  Useful when you want a relatively blank slate for testing purposes. 
  R is accessible via the command line or via RStudio Server.
  The release and devel versions of these containers (and the 
  *medium* and *large* containers built from them) are rebuilt
  daily with the latest versions of R-release or R-devel.
* *medium*: Built on *small*, so it contains everything in *small*, plus
  a number of Bioconductor packages to support many microarray, sequencing,
  flow cytometry, and proteomics workflows. See [the full list](#the-full-list)
  of packages installed.
* *large*: everything in *medium*, plus all 
  org.\* BSgenome.\* PolyPhen.\* SIFT.\* TxDb.\* annotation packages.
  This is a large download (?? GB). Only use if you really
  need all those annotation packages. If you only need
  a few, consider making your own container based on
  *medium* containing only the annotation packages
  you need.

## List of Containers

At present, the following containers <strikethrough>are</strikethrough>
(will soon be) available:

* bioconductor/devel_small
* bioconductor/devel_medium
* bioconductor/devel_large
* bioconductor/release_small
* bioconductor/release_medium
* bioconductor/release_large
<!--
* bioconductor/2.14_small
* bioconductor/2.14_medium
* bioconductor/2.14_large
-->

## Using the containers

The following examples use the `bioconductor/devel_small` container.
Note that you may need to prepend `sudo` to all `docker` commands.

##### To run RStudio Server:

    docker run -p 8787:8787 bioconductor/devel_small

You can then open a web browser pointing to your docker host on port 8787.
If you're on Linux and using default settings, the docker host is
`127.0.0.1` (or `localhost`, so the full URL to RStudio would be
`http://localhost:8787)`. If you are on Mac or Windows and running
`boot2docker`, you can determine the docker host with the
`boot2docker ip` command.

Log in to RStudio with the username `rstudio` and password `rstudio`.

##### To run R from the command line:

    docker run -ti bioconductor/devel_small R

##### To open a Bash shell on the container:

    docker run -ti bioconductor/devel_small bash

*Note*: The `docker run` command is very powerful and versatile. 
For full documentation, type `docker run --help` or visit
the [help page](https://docs.docker.com/reference/run/).

<a name="the-full-list"></a>
## List of packages installed on the *medium* container

These packages (and their dependencies) are installed.
If you have a suggestion or request for this list, please
[contact us](http://www.bioconductor.org/help/support/).
Note that we want to keep the *medium* container relatively
small, so it is not feasible to add every Bioconductor package to it.

* affxparser
* affy
* affyio
* affylmGUI
* annaffy
* annotate
* AnnotationDbi
* AnnotationHub
* aroma.light
* BayesPeak
* baySeq
* Biobase
* BiocInstaller
* BiocParallel
* biomaRt
* Biostrings
* BSgenome
* Category
* ChIPpeakAnno
* chipseq
* ChIPseqR
* ChIPsim
* CSAR
* cummeRbund
* DESeq
* DESeq2
* DEXSeq
* DiffBind
* DNAcopy
* DynDoc
* EDASeq
* edgeR
* epivizr
* ensemblVEP
* flowWorkspace
* gage
* genefilter
* geneplotter
* GenomeGraphs
* genomeIntervals
* GenomicFeatures
* GenomicRanges
* Genominator
* GEOquery
* GGBase
* GGtools
* girafe
* goseq
* GOstats
* graph
* GSEABase
* Gviz
* HilbertVis
* impute
* IRanges
* knitr
* limma
* MEDIPS
* MSnbase
* MSnID
* multtest
* mzID
* mzR
* oligo
* oneChannelGUI
* openCyto
* PAnnBuilder
* preprocessCore
* qpgraph
* qrqc
* R453Plus1Toolbox
* RBGL
* Repitools
* rGADEM
* Rgraphviz
* Ringo
* rmarkdown
* Rolexa
* Rsamtools
* Rsubread
* rtracklayer
* segmentSeq
* seqbias
* seqLogo
* ShortRead
* snpStats
* splots
* SRAdb
* tkWidgets
* VariantAnnotation
* vsn
* widgetTools
* xcms
* zlibbioc