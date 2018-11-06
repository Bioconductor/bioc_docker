# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

##
## Obtain list of packages in view, as defined in config.yml
##


wantedBiocViews <- c("Metabolomics")

url <- "http://www.bioconductor.org/packages/3.9/bioc/VIEWS"

t <- tempfile()
download.file(url, t)
dcf <- as.data.frame(read.dcf(t), stringsAsFactors=FALSE)

pkgs_matching_views <- c()

for (i in 1:nrow(dcf))
{
    row <- dcf[i,]
    if ((!is.na(row$biocViews)) && (!is.null(row$biocViews)))
    {
        views <- strsplit(gsub("\\s", "", row$biocViews), ",")[[1]]
        if(any(wantedBiocViews %in% views))
            pkgs_matching_views <- append(pkgs_matching_views, row$Package)
    }
}

ap.db <- available.packages(contrib.url(BiocManager::repositories()))
ap <- rownames(ap.db)

##
## Selection and fine-tuning of packages to install
##
pkgs_to_install <- pkgs_matching_views[pkgs_matching_views %in% ap]

# don't reinstall anything that's installed already
pkgs_to_install <- setdiff(pkgs_to_install, rownames(installed.packages()))

# Explicitly disable broken packages:

# https://github.com/Bioconductor/bioc_docker/issues/58
pkgs_to_install <- pkgs_to_install[!grepl("mQTL.NMR", pkgs_to_install)]

## Start the actual installation:
BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE)

# just in case there were warnings, we want to see them
# without having to scroll up:
warnings()

if (!is.null(warnings()))
{
    w <- capture.output(warnings())
    if (length(grep("is not available|had non-zero exit status", w)))
        quit("no", 1L)
}

suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))
