# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: <%= image_name %>.

FROM <%= parent %>2

MAINTAINER lg390@cam.ac.uk

RUN apt-get update && apt-get -y install \
    libudunits2-dev \
    tcl8.6-dev \
    tk    

ADD install.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

RUN R -f /tmp/install.R
