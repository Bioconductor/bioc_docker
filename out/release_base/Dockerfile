# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_base.

FROM rocker/rstudio

# FIXME? in release, default CRAN mirror is set to rstudio....should it be fhcrc?

MAINTAINER dtenenba@fredhutch.org


RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        gdb \
        libxml2-dev \
        python-pip 
#        valgrind

RUN pip install awscli





ADD install.R /tmp/

RUN R -f /tmp/install.R && \
    echo "library(BiocInstaller)" > $HOME/.Rprofile

