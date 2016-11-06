# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: sneumann/release_proteomics.

FROM sneumann/release_core

MAINTAINER maintainer@bioconductor.org

# temporarily block dist-upgrade:
#    apt-get dist-upgrade -y && \

RUN DEBIAN_FRONTEND=noninteractive apt-get update


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y  --force-yes libfreetype6

RUN apt-get update && \
    apt-get install -y  \
    libcairo2-dev \
    libexpat1-dev \
    libgmp3-dev \
    liblapack-dev \
    libnetcdf-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl-dev \
    openjdk-8-jdk



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
