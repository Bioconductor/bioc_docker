# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_flow.

FROM bioconductor/release_core

MAINTAINER dtenenba@fredhutch.org


RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN apt-get -t unstable install -y --force-yes libfreetype6=2.5.2-3
RUN apt-get -t unstable install -y \
    autoconf libcairo2-dev libgsl0-dev libgsl0ldbl libfftw3-dev \
    libgl1-mesa-dev libglu1-mesa-dev libhdf5-dev libjpeg-dev \
    libnetcdf-dev libtiff-dev libtool libxt-dev imagemagick

# flowWorkspace needs a newer version of protobuf than is available via apt-get
ADD https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz /tmp/protobuf-2.6.1.tar.gz

RUN cd /tmp && \
    tar -zxf /tmp/protobuf-2.6.1.tar.gz && \
    rm protobuf-2.6.1.tar.gz && \
    cd protobuf-2.6.1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# jump thru hoops to get ncdfFlow to build
RUN R -e "biocLite('rhdf5')" && \
    mkdir /tmp/fakehdf5 && \
    ln -s /usr/include/hdf5/serial/ /tmp/fakehdf5/include && \
    ln -s /usr/lib/x86_64-linux-gnu /tmp/fakehdf5/lib  && \
    ln -s /usr/local/lib/R/site-library/rhdf5/libs/rhdf5.so \
        /usr/lib/x86_64-linux-gnu/libhdf5.so && \
    R -e "biocLite(c('flowCore', 'flowViz', 'RcppArmadillo', 'BH', \
        'Biobase', 'zlibbioc', 'KernSmooth', 'mgcv'))" && \
    R -e "download.packages('ncdfFlow', '/tmp', repos=biocinstallRepos())" && \
    R CMD INSTALL /tmp/ncdfFlow_*.tar.gz --configure-args="--with-hdf5='/tmp/fakehdf5'"





ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN R -f /tmp/installFromBiocViews.R
RUN R -e "biocLite(c('flowWorkspaceData', 'RSVGTipsDevice'))"

