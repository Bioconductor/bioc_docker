# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_base.

FROM rocker/rstudio

# FIXME? in release, default CRAN mirror is set to rstudio....should it be fhcrc?

MAINTAINER dtenenba@fredhutch.org


RUN apt-get update && \
    apt-get -y -t unstable install gdb libxml2-dev python-pip
    # valgrind

RUN pip install awscli



RUN apt-get -y -t unstable install --fix-missing  texlive texinfo





ADD install.R /tmp/

RUN R -f /tmp/install.R && \
    echo "library(BiocInstaller)" > $HOME/.Rprofile

