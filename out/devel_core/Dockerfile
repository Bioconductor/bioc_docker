# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_core.

FROM bioconductor/devel_base

MAINTAINER dtenenba@fredhutch.org



ADD install.R /tmp/

RUN R -f /tmp/install.R



