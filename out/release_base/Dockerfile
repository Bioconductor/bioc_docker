# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/release_base.

FROM rocker/rstudio

# FIXME? in release, default CRAN mirror is set to rstudio....should it be fhcrc?

MAINTAINER maintainer@bioconductor.org

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


# temporarily (?) change mirror used
# RUN sed -i.bak 's!http://httpredir.debian.org/debian jessie main!http://mirrors.kernel.org/debian jessie main!' /etc/apt/sources.list

# temporarily (?) remove explicit jessie source
#RUN sed -i.bak -e '/deb http:..ftp.de.debian.org.debian jessie main/d' /etc/apt/sources.list




RUN apt-get update && \
    apt-get -y  install --fix-missing gdb libxml2-dev python-pip libz-dev libmariadb-client-lgpl-dev
    # valgrind


RUN pip install awscli





ADD install.R /tmp/

RUN R -f /tmp/install.R && \
    echo "library(BiocInstaller)" > $HOME/.Rprofile
