# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_microarray.

FROM bioconductor/release_core

MAINTAINER dtenenba@fredhutch.org

# temporarily block dist-upgrade:
#     DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \



RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binutils \
    curl \
    dpkg-dev \
    g++ \
    gcc \
    git \
    ggobi \
    libcairo2-dev \
    libgsl0-dev \
    libgsl0ldbl \
    libjpeg-dev \
    libgtk2.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgmp3-dev \
    libpng-dev \
    libmysqlclient15-dev \
    libnetcdf-dev \
    libtiff-dev \
    libxpm-dev \
    libx11-dev \
    libxpm-dev \
    libxft-dev \
    libxext-dev \
    make \
    mysql-server \
    openjdk-8-jdk \
    tk-dev



ENV PATH=$PATH:/usr/local/root/bin \
    ROOTSYS=/usr/local/root

 RUN cd /tmp && \
     ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libtiff.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libpng.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libX11.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libXft.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libXpm.so /usr/lib && \
     ln -s /usr/lib/x86_64-linux-gnu/libXext.so /usr/lib  && \
     curl -kO ftp://root.cern.ch/root/root_v5.34.24.source.tar.gz && \
     tar zxf root_v5.34.24.source.tar.gz && cd root && \
     ./configure linuxx8664gcc --prefix=/usr/local/root && \
     make -j2 && make install && \
     echo /usr/local/root/lib/root > /etc/ld.so.conf.d/ROOT.conf && \
     ldconfig


ADD startx.sh /tmp/

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include


ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/


# FIXME - note that Xvfb is never actually installed, and yet
# things seem to work(?). Do we need to invoke startx.sh below?

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R
