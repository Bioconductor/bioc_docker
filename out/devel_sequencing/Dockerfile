# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_sequencing.

FROM bioconductor/devel_core

MAINTAINER dtenenba@fredhutch.org

# temporarily block dist-upgrade:
#    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \


RUN DEBIAN_FRONT_END=noninteractive apt-get install -y --force-yes libfreetype6=2.5.2-3

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
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



RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libblas-dev \
    libbz2-dev \
    liblapack-dev \
    liblzma-dev && \
    sed -i''  's/-pedantic//' /usr/local/lib/R/etc/Makeconf 



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

