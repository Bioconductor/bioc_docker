# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel/microarray.

FROM bioconductor/devel_core

ADD installFromBiocViews.R /tmp/

RUN R -f /tmp/installFromBiocViews.R
