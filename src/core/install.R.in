# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

library(BiocInstaller) # shouldn't be necessary

# temporary workaround since the CRAN version of matrixStats will not build
if (!BiocInstaller:::IS_USER) # if this is devel
{
    biocLite("devtools")
    library(devtools)
    install_github("HenrikBengtsson/matrixStats")
}


pkgs <- c(
"AnnotationDbi",
"AnnotationHub",
"Biobase",
"BiocParallel",
"biocViews",
"biomaRt",
"Biostrings",
"BSgenome",
"epivizr",
"GenomicFeatures",
"GenomicRanges",
"graph",
"Gviz",
"httr",
"IRanges",
"knitr",
"RBGL",
"RCurl",
# temporarily comment out ReportingTools as it is not building:
#"ReportingTools",
"Rgraphviz",
"rmarkdown",
"XML",
"zlibbioc"
)

ap.db <- available.packages(contrib.url(biocinstallRepos()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

biocLite(pkgs_to_install)

# just in case there were warnings, we want to see them
# without having to scroll up:
warnings()

if (!is.null(warnings()))
{
    w <- capture.output(warnings())
    if (length(grep("is not available|had non-zero exit status", w)))
        quit("no", 1L)
}
