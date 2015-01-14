# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_base.

FROM ubuntu:14.04

MAINTAINER dtenenba@fredhutch.org

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive \ 
    apt-get build-dep -y r-base && \
    DEBIAN_FRONTEND=noninteractive \
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
    libssl0.9.8 \
    libxml2-dev \
    mpich2 \
    openmpi-bin \
    openmpi-checkpoint \
    openmpi-common \
    pgf \
    psmisc \
    python-pip \
    supervisor \
    texlive-science \
    unzip \
    valgrind \
    wget && \
    pip install -U awscli

# we need a pandoc that's newer than what apt-get provides
RUN cd /tmp && curl -LO https://github.com/jgm/pandoc/releases/download/1.13.2/pandoc-1.13.2-1-amd64.deb && \
    dpkg -i pandoc-1.13.2-1-amd64.deb && rm pandoc-1.13.2-1-amd64.deb

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
&& locale-gen en_US.utf8 \
&& /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8


RUN rm -rf /tmp/R-source && mkdir /tmp/R-source

ADD http://cran.fhcrc.org/src/base/R-latest.tar.gz /tmp/R-source/

RUN cd /tmp/R-source && \
    tar -zxf /tmp/R-source/*.tar.gz && \
    rm *.tar.gz && \
    cd R-* && \
    ./configure --enable-R-shlib && \
    make && \
    make install


ADD install.R /tmp/

RUN R -f /tmp/install.R && \
    echo "library(BiocInstaller)" > $HOME/.Rprofile

# rstudio

RUN VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \
    wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb && \
    dpkg -i rstudio-server-${VER}-amd64.deb && \
    rm rstudio-server-*-amd64.deb

ADD userconf.sh /usr/bin/

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8787

CMD ["/usr/bin/supervisord"] 
