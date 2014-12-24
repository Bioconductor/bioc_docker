# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_large.

FROM bioconductor/release_medium

MAINTAINER dtenenba@fredhutch.org

ADD install.R /tmp/

RUN R -f /tmp/install.R
