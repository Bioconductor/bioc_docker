# DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

pkgs <- c("MSnbase", "cleaver", "customProDB", "DAPAR", "MSGFplus",
          "MSGFgui", "rTANDEM", "MassSpecWavelet", "RankProd",
          "ChemmineR", "isobar", "msmsEDA", "msmsTests", "MSnID",
          "mzID", "MSstats", "proBAMr", "Prostar", "rpx", "hpar",
          "RforProteomics", "SWATH2stats", "specL", "PROcess",
          "proteoQC", "pRoloc", "pRolocdata", "synapter",
          "synapterdata", "pathview", "BRAIN", "biobroom")

ap.db <- available.packages(contrib.url(BiocManager::repositories()))
ap <- rownames(ap.db)
pkgs_to_install <- pkgs[pkgs %in% ap]

ok <- BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE) %in% rownames(installed.packages())
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))
