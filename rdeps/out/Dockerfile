# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/rdeps.

FROM ubuntu:14.04

MAINTAINER dtenenba@fredhutch.org

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive \ 
    apt-get build-dep -y r-base

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    biber \
    curl \
    dh-autoreconf \
    dvipng \
    gdb \
    gdebi-core \
    libarchive-zip-perl \
    libcurl4-openssl-dev \
    libdbd-mysql-perl \
    libdbi-perl \
    libhdf5-dev \
    libmpich2-dev \
    libnetcdf-dev \
    libopenmpi-dev \
    libopenmpi1.6 \
    libqt4-opengl-dev \
    libxml2-dev \
    mpich2 \
    openmpi-bin \
    openmpi-checkpoint \
    openmpi-common \
    pandoc \
    python-pip \
    texlive-science \
    unzip \
    valgrind

RUN pip install -U awscli

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


