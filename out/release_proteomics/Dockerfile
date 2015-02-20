# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_proteomics.

FROM bioconductor/release_core

MAINTAINER dtenenba@fredhutch.org

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libexpat1-dev \
    libgmp3-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libgsl0ldbl \
    openjdk-8-jdk

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include


RUN cd /usr/lib/R/etc && \
    sed s/error=format-security/format-security/g < Makeconf > Makeconf.new && \
    mv Makeconf Makeconf.old && \
    mv Makeconf.new Makeconf && cd -


ADD installFromBiocViews.R /tmp/

RUN R -f /tmp/installFromBiocViews.R
