# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

library(BiocInstaller) # shouldn't be necessary

ap <- rownames(available.packages(
    contrib.url(biocinstallRepos()['BioCann'], getOption("pkgType"))))
annoPkgs <- 
    ap[grep("^org\\.|^BSgenome\\.|^PolyPhen\\.|^SIFT\\.|^TxDb\\.", ap)]

biocLite(annoPkgs)

warnings()

if (!is.null(warnings()))
{
    w <- capture.output(warnings())
    if (grep("is not available", w))
        quit("no", 1L)
}

