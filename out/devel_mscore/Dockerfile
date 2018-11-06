# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_mscore.

FROM bioconductor/devel_base2

MAINTAINER lg390@cam.ac.uk

RUN apt-get update -qq && \
    apt-get install -y  -t unstable  --no-install-recommends \
    libxt-dev libx11-dev libcairo2-dev \
    libfreetype6 \    
    libexpat1-dev \
    libgmp3-dev \
    libopenbabel-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl0-dev \
    pkg-config \
    fftw3-dev \
    libgtk2.0-dev \
    libtiff5-dev \
    libmpfr-dev \
    liblapack-dev \
    cmake \
    default-jdk \
    libnetcdf-dev \
    libpng-dev \
    libbz2-dev \
    liblzma-dev \
    libpcre3-dev \
    libicu-dev

RUN R CMD javareconf

ENV NETCDF_INCLUDE=/usr/include

ADD install.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN R -f /tmp/install.R
