# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_proteomics.

FROM bioconductor/devel_core

MAINTAINER dtenenba@fredhutch.org

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libexpat1-dev \
    libgmp3-dev \
    libnetcdf-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libgsl0ldbl \
    openjdk-8-jdk

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include



ADD installFromBiocViews.R /tmp/

RUN R -f /tmp/installFromBiocViews.R
