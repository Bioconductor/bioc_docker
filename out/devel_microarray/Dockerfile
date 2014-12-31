# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_microarray.

FROM bioconductor/devel_core

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl0-dev libgsl0ldbl mysql-server libmysqlclient15-dev \
     libgtk2.0-dev libgmp3-dev libxpm-dev git dpkg-dev make g++ \
     gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev

RUN cd /tmp && \
    curl -kO https://root.cern.ch/download/root_v6.02.02.source.tar.gz && \
    tar zxf root_v6.02.02.source.tar.gz && cd root-6.02.02 && \
    ./configure --prefix=/usr/local/root && \
    make -j && make install && \
    echo "export PATH=$PATH:/usr/local/root/bin >> /etc/profile" && \
    echo /usr/local/root/lib/root > /etc/ld.so.conf.d/ROOT.conf && \
    ldconfig

ADD installFromBiocViews.R /tmp/

RUN R -f /tmp/installFromBiocViews.R
