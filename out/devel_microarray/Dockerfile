# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_microarray.

FROM bioconductor/devel_core

MAINTAINER dtenenba@fredhutch.org

# temporarily block dist-upgrade:
#     apt-get dist-upgrade -y && \


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y && \
    apt-get update -y && \
    apt-get -t unstable upgrade -y


RUN apt-get -t unstable install -y --force-yes libfreetype6=2.5.2-3

RUN echo "" | sudo debconf-set-selections

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -t unstable install -q -y \
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
    tk-dev \
    Xvfb


RUN apt-get install -y -t unstable\
    libblas-dev \
    libbz2-dev \
    liblapack-dev


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



RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R
