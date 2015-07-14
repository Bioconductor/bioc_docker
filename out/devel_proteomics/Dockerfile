# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_proteomics.

FROM bioconductor/devel_core

MAINTAINER dtenenba@fredhutch.org

# temporarily block dist-upgrade:
#    apt-get dist-upgrade -y && \

RUN DEBIAN_FRONTEND=noninteractive apt-get update


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y -t unstable --force-yes libfreetype6#=2.5.2-3

RUN apt-get update && \
    apt-get install -y -t unstable \
    libexpat1-dev \
    libgmp3-dev \
    libnetcdf-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libgsl0ldbl \
    openjdk-8-jdk


RUN apt-get install -y -t unstable \
    libbz2-dev liblzma-dev libpcre3-dev libpng12-dev 



RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include

ADD startx.sh /tmp/


ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/


RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R

RUN R -e "biocLite(c('rols', 'RforProteomics'))"

