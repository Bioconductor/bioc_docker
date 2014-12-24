# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/2.14_large.

FROM bioconductor/2.14_medium

MAINTAINER dtenenba@fredhutch.org

ADD install.R /tmp/

RUN R -f /tmp/install.R
