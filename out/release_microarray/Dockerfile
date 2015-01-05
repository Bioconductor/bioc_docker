# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_microarray.

FROM bioconductor/release_core

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl0-dev libgsl0ldbl mysql-server libmysqlclient15-dev \
     libgtk2.0-dev libgmp3-dev libxpm-dev git dpkg-dev make g++ \
     gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev ggobi

ENV PATH=$PATH:/usr/local/root/bin \
    ROOTSYS=/usr/local/root

 RUN cd /tmp && \
     curl -kO ftp://root.cern.ch/root/root_v5.34.24.source.tar.gz && \
     tar zxf root_v5.34.24.source.tar.gz && cd root && \
     ./configure --prefix=/usr/local/root && \
     make -j2 && make install && \
     echo /usr/local/root/lib/root > /etc/ld.so.conf.d/ROOT.conf && \
     ldconfig


ADD startx.sh /tmp/

ADD installFromBiocViews.R /tmp/

# the gdsfmt part can go away when gdsfmt is accepted into bioc:
RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    curl -O http://cran.r-project.org/src/contrib/Archive/gdsfmt/gdsfmt_1.1.0.tar.gz && \
    R CMD INSTALL /tmp/gdsfmt_1.1.0.tar.gz && \
    R -f /tmp/installFromBiocViews.R

