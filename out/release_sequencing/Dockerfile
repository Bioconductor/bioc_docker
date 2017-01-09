# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_sequencing.

FROM bioconductor/release_core

MAINTAINER maintainer@bioconductor.org

# temporarily block dist-upgrade:
#   RUN apt-get dist-upgrade -y && \

RUN DEBIAN_FRONTEND=noninteractive apt-get update


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y  --force-yes libfreetype6




RUN apt-get update && \
    apt-get install -y  --fix-missing \
    curl \
    libcairo2-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl-dev \
    libgtk2.0-dev \
    libncurses5-dev \
    openjdk-8-jdk \
    tk-dev \
    xvfb





# sourceforge is on the fritz today
COPY JAGS-4.0.1.tar.gz /tmp/JAGS-4.0.1.tar.gz

RUN cd /tmp && \
    tar zxf /tmp/JAGS-4.0.1.tar.gz && \
    cd JAGS-4.0.1 && \
    ./configure --prefix=/usr/local && \
    make -j && \
    make install


ENV JAGS_INCLUDE=/usr/local/include/JAGS JAGS_LIB=/usr/local/lib \
    JAGS_MODULES=/usr/local/lib/JAGS/modules-4

ENV LD_LIBRARY_PATH=${JAGS_LIB}

ADD startx.sh /tmp/

RUN R CMD javareconf




ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R
