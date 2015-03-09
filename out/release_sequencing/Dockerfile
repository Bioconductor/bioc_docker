# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_sequencing.

FROM bioconductor/release_core

MAINTAINER dtenenba@fredhutch.org


RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
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

