# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_sequencing.

FROM bioconductor/devel_core


RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl0-dev libgsl0ldbl libgtk2.0-dev

RUN cd /tmp && \
    curl -L http://sourceforge.net/projects/mcmc-jags/files/JAGS/3.x/Source/JAGS-3.4.0.tar.gz/download > JAGS-3.4.0.tar.gz && \
    tar zxf JAGS-3.4.0.tar.gz && \
    cd JAGS-3.4.0 && \
    ./configure --prefix=/usr/local && \
    make -j && \
    make install 


ENV JAGS_INCLUDE=/usr/local/include/JAGS JAGS_LIB=/usr/local/lib \
    JAGS_MODULES=/usr/local/lib/JAGS/modules-3

ADD startx.sh /tmp/

ADD installFromBiocViews.R /tmp/

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R

