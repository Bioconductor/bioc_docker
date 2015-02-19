# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_microarray.

FROM bioconductor/devel_core

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl0-dev libgsl0ldbl mysql-server libmysqlclient15-dev \
     libgtk2.0-dev libgmp3-dev libxpm-dev git dpkg-dev make g++ \
     gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev ggobi

ENV PATH=$PATH:/usr/local/root/bin \
    ROOTSYS=/usr/local/root

# FIXME - merge this w/above:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl libx11-dev


 RUN cd /tmp && \
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

ADD installFromBiocViews.R /tmp/

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R
