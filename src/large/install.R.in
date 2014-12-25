# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

library(BiocInstaller) # shouldn't be necessary

ap <- rownames(available.packages(
    contrib.url(biocinstallRepos()['BioCann'], getOption("pkgType"))))
annoPkgs <- 
    ap[grep("^org\\.|^BSgenome\\.|^PolyPhen\\.|^SIFT\\.|^TxDb\\.|^XtraSNPlocs\\.", ap)]

#biocLite(annoPkgs)


destdir <- file.path(tempdir(), "downloaded.packages")
dir.create(destdir)

# use some tricks to download/install quickly so docker hub automated build
# does not time out


fun <- function(x)
{
    print(paste("downloading and installing", x))
    res <- download.packages(x, destdir, repos=biocinstallRepos())
    install.packages(res[2], repos=NULL)
}

library(parallel)

print("number of cores:")
print(detectCores())

mclapply(annoPkgs, fun, mc.cores=detectCores())

# warnings()

#if (!is.null(warnings()))
#{
#    w <- capture.output(warnings())
#    if (grep("is not available", w))
#        quit("no", 1L)
#}

