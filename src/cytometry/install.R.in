# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

pkgs <- c("biocViews", "CytoML", "roxygen2", "devtools")

ap.db <- available.packages(contrib.url(BiocManager::repositories()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

ok <- BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE, dependencies = TRUE) %in% rownames(installed.packages())
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))
