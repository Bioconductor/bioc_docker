# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_metabolomics.

FROM bioconductor/release_core

MAINTAINER sneumann@ipb-halle.de

# temporarily block dist-upgrade:
#    apt-get dist-upgrade -y && \

RUN DEBIAN_FRONTEND=noninteractive apt-get update


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y -t unstable --force-yes libfreetype6

RUN apt-get update && \
    apt-get install -y -t unstable \
    libcairo2-dev \
    libexpat1-dev \
    libgmp3-dev \
    liblapack-dev \
    libnetcdf-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libgsl0ldbl \
    openjdk-8-jdk



# For tofsims
RUN apt-get install -y -t unstable \
    liblapack-dev cmake

# For SUNDIAL
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-cvode0_2.3.0-2_amd64.deb
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-cvodes1_2.3.0-2_amd64.deb
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-ida1_2.3.0-2_amd64.deb
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-kinsol0_2.3.0-2_amd64.deb
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-nvecserial0_2.3.0-2_amd64.deb

RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-serial_2.3.0-2_amd64.deb
RUN wget http://snapshot.debian.org/archive/debian/20100407T220820Z/pool/main/s/sundials/libsundials-serial-dev_2.3.0-2_amd64.deb

RUN dpkg -i libsundials-cvode0_2.3.0-2_amd64.deb libsundials-cvodes1_2.3.0-2_amd64.deb libsundials-ida1_2.3.0-2_amd64.deb libsundials-kinsol0_2.3.0-2_amd64.deb libsundials-nvecserial0_2.3.0-2_amd64.deb libsundials-serial_2.3.0-2_amd64.deb libsundials-serial-dev_2.3.0-2_amd64.deb

RUN bash -i -c 'wget -O libSBML-5.10.2-core-src.tar.gz http://downloads.sourceforge.net/project/sbml/libsbml/5.10.2/stable/libSBML-5.10.2-core-src.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsbml%2Ffiles%2Flibsbml%2F5.10.2%2Fstable%2F && (tar xzvf libSBML-5.10.2-core-src.tar.gz ; cd libsbml-5.10.2 && CXXFLAGS=-fPIC CFLAGS=-fPIC ./configure && make -j 8 && make install ) &&  wget -O rsbml_2.31.0.tar.gz http://bioconductor.org/packages/3.4/bioc/src/contrib/rsbml_2.31.0.tar.gz && tar -xzvf rsbml_2.31.0.tar.gz && cd rsbml && R CMD INSTALL . '

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include

ADD startx.sh /tmp/


ADD installFromBiocViews.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/


RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/installFromBiocViews.R
