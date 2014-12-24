# DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# with the 'rake' command.

# The suggested name for this image is: bioconductor/bioc_2.14.

FROM bioconductor.org/rdeps

MAINTAINER dtenenba@fredhutch.org

RUN rm -rf /tmp/R-source && mkdir /tmp/R-source

ADD http://cran.r-project.org/src/base/R-3/R-3.1.2.tar.gz /tmp/R-source/

RUN cd /tmp/R-source && \
    tar -zxf /tmp/R-source/*.tar.gz && \
    rm *.tar.gz && \
    cd R-* && \
    ./configure --enable-R-shlib && \
    make && \
    make install


ADD install.R /tmp/

RUN R -f /tmp/install.R

ADD install_vep.sh /tmp/

RUN /tmp/install_vep.sh

# create .Rprofile...

RUN echo "library(BiocInstaller)" > $HOME/.Rprofile


# rstudio

RUN VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \
    wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb && \
    dpkg -i rstudio-server-${VER}-amd64.deb && \
    rm rstudio-server-*-amd64.deb

ADD userconf.sh /tmp/

RUN /tmp/userconf.sh

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8787

CMD ["/usr/bin/supervisord"] 

