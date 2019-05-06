# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_metabolomics.

FROM bioconductor/release_protmetcore2

MAINTAINER sneumann@ipb-halle.de

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    libfreetype6 \
    libcairo2-dev \
    libexpat1-dev \
    libgmp3-dev \
    liblapack-dev \
    libnetcdf-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    libmpfr-dev \
    pkg-config \
    fftw3-dev \
    libgtk2.0-dev \
    libtiff5-dev \
    libnetcdf-dev \
    libmpfr-dev \
    libnetcdf-dev \
    liblapack-dev \
    cmake \
    tcl8.6 tk8.6 \
    default-jdk \
    libnetcdf-dev libpng-dev libbz2-dev liblzma-dev libpcre3-dev libicu-dev \
    libudunits2-dev libgdal-dev

RUN bash -i -c 'wget -O libSBML-5.10.2-core-src.tar.gz http://downloads.sourceforge.net/project/sbml/libsbml/5.10.2/stable/libSBML-5.10.2-core-src.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsbml%2Ffiles%2Flibsbml%2F5.10.2%2Fstable%2F && tar xzvf libSBML-5.10.2-core-src.tar.gz ; cd libsbml-5.10.2 && CXXFLAGS=-fPIC CFLAGS=-fPIC ./configure --prefix=/usr && make && make install && ldconfig'

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include

ENV OPEN_BABEL_LIBDIR /usr/lib/openbabel/2.3.2/
ENV OPEN_BABEL_INCDIR /usr/include/openbabel-2.0/

ADD install.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN R -f /tmp/install.R
