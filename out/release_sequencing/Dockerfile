# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_sequencing.

FROM bioconductor/release_core


RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl0-dev libgsl0ldbl libgtk2.0-dev

RUN cd /tmp && \
    curl -L http://sourceforge.net/projects/mcmc-jags/files/JAGS/3.x/Source/JAGS-3.4.0.tar.gz/download > JAGS-3.4.0.tar.gz && \
    tar zxf JAGS-3.4.0.tar.gz && \
    cd JAGS-3.4.0 && \
    ./configure --prefix=/usr/local && \
    make -j && \
    make install 


ENV JAGS_INCLUDE=/usr/local/include/JAGS \
    JAGS_LIB=/usr/local/lib \
    JAGS_MODULES=/usr/local/lib/JAGS/modules-3 

ADD start-virtual-X.sh /tmp/

ADD installFromBiocViews.R /tmp/

# the gdsfmt part can go away when gdsfmt is accepted into bioc:
# the VGAM part can go away when casper is fixed
RUN . /tmp/start-virtual-X.sh > /dev/null 2>&1 && \
    cd /tmp && \
    curl -O http://cran.r-project.org/src/contrib/Archive/gdsfmt/gdsfmt_1.1.0.tar.gz && \
    R CMD INSTALL /tmp/gdsfmt_1.1.0.tar.gz && \
    curl -O http://cran.r-project.org/src/contrib/Archive/VGAM/VGAM_0.9-4.tar.gz && \
    R CMD INSTALL /tmp/VGAM_0.9-4.tar.gz && \
    R -f /tmp/installFromBiocViews.R
