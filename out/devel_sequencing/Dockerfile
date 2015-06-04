# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_sequencing.

FROM bioconductor/devel_core

MAINTAINER dtenenba@fredhutch.org

# temporarily block dist-upgrade:
#   RUN apt-get dist-upgrade -y && \

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y -t unstable --force-yes libfreetype6=2.5.2-3


RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*



RUN apt-get update && \
    apt-get install -y -t unstable --fix-missing \
    curl \
    libcairo2-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libgsl0ldbl \
    libgtk2.0-dev \
    openjdk-8-jdk \
    tk-dev \
    xvfb



RUN apt-get install -y -t unstable \
    libblas-dev \
    libbz2-dev \
    liblapack-dev \
    liblzma-dev 



RUN cd /tmp && \
    curl -L http://sourceforge.net/projects/mcmc-jags/files/JAGS/3.x/Source/JAGS-3.4.0.tar.gz/download > JAGS-3.4.0.tar.gz && \
    tar zxf JAGS-3.4.0.tar.gz && \
    cd JAGS-3.4.0 && \
    ./configure --prefix=/usr/local && \
    make -j && \
    make install 


ENV JAGS_INCLUDE=/usr/local/include/JAGS JAGS_LIB=/usr/local/lib \
    JAGS_MODULES=/usr/local/lib/JAGS/modules-3

ENV LD_LIBRARY_PATH=${JAGS_LIB}

ADD startx.sh /tmp/

RUN R CMD javareconf




ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R

