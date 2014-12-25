# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_proteomics.

FROM bioconductor/devel_core

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgmp3-dev libopenbabel-dev libgsl0-dev libgsl0ldbl

ADD installFromBiocViews.R /tmp/

RUN R -f /tmp/installFromBiocViews.R
