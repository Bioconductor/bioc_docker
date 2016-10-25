# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: sneumann/devel_microarray.

FROM sneumann/devel_core

MAINTAINER maintainer@bioconductor.org

# temporarily block dist-upgrade:
#     apt-get dist-upgrade -y && \


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y && \
    apt-get update -y && \
    apt-get -t unstable upgrade -y



RUN apt-get remove -y r-base-core
RUN rm -rf /usr/lib/R/library



RUN apt-get -t unstable install -y --force-yes libfreetype6

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
    libgsl-dev \
    libjpeg-dev \
    libgtk2.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgmp3-dev \
    libpng-dev \
    libmysqlclient-dev \
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
    xvfb


RUN apt-get install -y -t unstable\
    libblas-dev \
    libbz2-dev \
    liblapack-dev


ENV ROOTSYS=/opt/ROOT/root
ENV PATH=$ROOTSYS/bin:$PATH
ENV LD_LIBRARY_PATH=$ROOTSYS/lib:/usr/lib

RUN cd / && \
  curl -LO http://s3.amazonaws.com/bioc-root-binary/rootbinary.tar.gz \
  && tar zxf rootbinary.tar.gz && \
  rm rootbinary.tar.gz

ADD startx.sh /tmp/

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include


ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/



RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0

RUN  R -f /tmp/installFromBiocViews.R
