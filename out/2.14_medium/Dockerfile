# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/2.14_medium.

FROM bioconductor/2.14_small

MAINTAINER dtenenba@fredhutch.org

ADD install.R /tmp/

RUN R -f /tmp/install.R

ADD install_vep.sh /tmp/

RUN /tmp/install_vep.sh


