# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/devel_base.

FROM rocker/rstudio-daily

# FIXME? in release, default CRAN mirror is set to rstudio....should it be fhcrc?

MAINTAINER maintainer@bioconductor.org

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


# temporarily (?) change mirror used
# RUN sed -i.bak 's!http://httpredir.debian.org/debian jessie main!http://mirrors.kernel.org/debian jessie main!' /etc/apt/sources.list

# temporarily (?) remove explicit jessie source
#RUN sed -i.bak -e '/deb http:..ftp.de.debian.org.debian jessie main/d' /etc/apt/sources.list


RUN apt-get update && \
    apt-get -y  install --fix-missing -t unstable gdb libxml2-dev python-pip
    # valgrind




RUN pip install awscli



RUN apt-get update && \
    apt-get -y -f install --fix-missing texlive texlive-latex-base texlive-fonts-recommended texinfo texlive-fonts-extra texlive-latex-extra




# There should only be one version of R on this container
#RUN dpkg --purge --force-depends r-base-core
# FIXME figure out how to REALLY remove r-base-core and deps
# so that it does not come back.


# issues with '/var/lib/dpkg/available' not found
# this will recreate
RUN dpkg --clear-avail
RUN apt-get update 
RUN apt-get remove -y r-base-core



ADD install.R /tmp/

RUN R -f /tmp/install.R && \
    echo "library(BiocInstaller)" > $HOME/.Rprofile
