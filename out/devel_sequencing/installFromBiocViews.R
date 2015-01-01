# DO NOT EDIT 'installFromBiocViews.R'; instead, edit 'installFromBiocViews.R.in' and
# use 'rake' to generate 'installFromBiocViews.R'.

library(BiocInstaller) # shouldn't be necessary

wantedBiocViews <- c("Sequencing")

url <- "http://www.bioconductor.org/packages/3.1/bioc/VIEWS"

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

ap.db <- available.packages(contrib.url(biocinstallRepos()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs_matching_views[pkgs_matching_views %in% ap]

# don't install casper until it is compatible with newest VGAM
pkgs_to_install <- pkgs_to_install[grep("casper", invert=TRUE)]

# don't reinstall anything that's installed already
pkgs_to_install <- setdiff(pkgs_to_install, rownames(installed.packages()))

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

