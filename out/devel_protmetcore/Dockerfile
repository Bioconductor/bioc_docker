# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_protmetcore.

FROM bioconductor/devel_core2

MAINTAINER sneumann@ipb-halle.de

RUN apt-get update -qq && \
    apt-get install -y  -t unstable  --no-install-recommends \
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
    default-jdk \
    libnetcdf-dev libpng-dev libbz2-dev liblzma-dev libpcre3-dev libicu-dev

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include


ADD install.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN R -f /tmp/install.R
