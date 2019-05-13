
# Bioconductor Dockers #

## Overview ##

This repository contains Dockerfiles for different Docker containers of interest
for Bioconductor users.  Additional information about available containers,
installation and modification can be found on the [Bioconductor Docker
Page](http://bioconductor.org/help/docker/) or [Docker
installation](https://docs.docker.com/installation/).


## Available Docker Containers ##

See also [Bioconductor Docker Page](http://bioconductor.org/help/docker/).

#### Maintained by the Bioconductor Core Team: bioc-issue-bot@bioconductor.org:

| Docker Container  | Docker Hub Latest Version  | Image Size | Build status
| :------------------------- | :----------------- | :---------- | :----------
| release_base2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_base)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_base2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_base2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_base2/)  | [![](https://images.microbadger.com/badges/image/bioconductor/release_base2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_base2/)| [![](https://img.shields.io/docker/cloud/build/bioconductor/release_base2.svg)](https://hub.docker.com/r/bioconductor/release_base2/builds/)
| release_core2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_core)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_core2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_core2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_core2/)  | [![](https://images.microbadger.com/badges/image/bioconductor/release_core2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_core2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_core2.svg)](https://hub.docker.com/r/bioconductor/release_core2/builds/)
| devel_base2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_base)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_base2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_base2.svg)](https://hub.docker.com/r/bioconductor/devel_base2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_base2.svg)](https://hub.docker.com/r/bioconductor/devel_base2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_base2.svg)](https://hub.docker.com/r/bioconductor/devel_base2/builds/)
| devel_core2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_core)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_core2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_core2.svg)](https://hub.docker.com/r/bioconductor/devel_core2/)  | [![](https://images.microbadger.com/badges/image/bioconductor/devel_core2.svg)](https://hub.docker.com/r/bioconductor/devel_core2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_core2.svg)](https://hub.docker.com/r/bioconductor/devel_core2/builds/)


#### Maintained by Steffen Neumann: sneumann@ipb-halle.de
Maintained as part of the “PhenoMeNal, funded by Horizon2020 grant 654241”

| Docker Container  | Docker Hub Latest Version  | Image Size | Build status
| :------------------------- | :----------------- | :---------- | :----------
| release_protmetcore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_protmetcore)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_protmetcore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_protmetcore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_protmetcore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_protmetcore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_protmetcore2/)  | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_protmetcore2.svg)](https://hub.docker.com/r/bioconductor/release_protmetcore2/builds/)
| release_metabolomics2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_metabolomics)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_metabolomics2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_metabolomics2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_metabolomics2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_metabolomics2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_metabolomics2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_metabolomics2.svg)](https://hub.docker.com/r/bioconductor/release_metabolomics2/builds/)
| devel_protmetcore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_protmetcore)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_protmetcore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_protmetcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protmetcore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_protmetcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protmetcore2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_protmetcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protmetcore2/builds/)
| devel_metabolomics2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_metabolomics)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_metabolomics2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_metabolomics2.svg)](https://hub.docker.com/r/bioconductor/devel_metabolomics2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_metabolomics2.svg)](https://hub.docker.com/r/bioconductor/devel_metabolomics2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_metabolomics2.svg)](https://hub.docker.com/r/bioconductor/devel_metabolomics2/builds/)


#### Maintained by Laurent Gatto: lg390@cam.ac.uk

| Docker Container  | Docker Hub Latest Version  | Image Size | Build status
| :------------------------- | :----------------- | :---------- | :----------
| release_mscore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_mscore)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_mscore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_mscore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_mscore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_mscore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_mscore2/)  | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_mscore2.svg)](https://hub.docker.com/r/bioconductor/release_mscore2/builds/)
| release_protcore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_protcore)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_protcore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_protcore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_protcore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_protcore2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_protcore2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_protcore2.svg)](https://hub.docker.com/r/bioconductor/release_protcore2/builds/)
| release_proteomics2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_proteomics)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_proteomics2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_proteomics2:R3.4.4_Bioc3.6.svg)](https://hub.docker.com/r/bioconductor/release_proteomics2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_proteomics2:R3.4.4_Bioc3.6.svg)](https://hub.docker.com/r/bioconductor/release_proteomics2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_proteomics2.svg)](https://hub.docker.com/r/bioconductor/release_proteomics2/builds/)
| devel_mscore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_mscore)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_mscore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_mscore2.svg)](https://hub.docker.com/r/bioconductor/devel_mscore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_mscore2.svg)](https://hub.docker.com/r/bioconductor/devel_mscore2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_mscore2.svg)](https://hub.docker.com/r/bioconductor/devel_mscore2/builds/)
| devel_protcore2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_protcore)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_protcore2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_protcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protcore2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_protcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protcore2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_protcore2.svg)](https://hub.docker.com/r/bioconductor/devel_protcore2/builds/)
| devel_proteomics2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_proteomics)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_proteomics2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_proteomics2.svg)](https://hub.docker.com/r/bioconductor/devel_proteomics2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_proteomics2.svg)](https://hub.docker.com/r/bioconductor/devel_proteomics2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_proteomics2.svg)](https://hub.docker.com/r/bioconductor/devel_proteomics2/builds/)

#### Maintained by RGLab: wjiang2@fredhutch.org

| Docker Container  | Docker Hub Latest Version  | Image Size | Build status
| :------------------------- | :----------------- | :---------- | :----------
| release_cytometry2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/release_cytometry)) ([DockerHub](https://hub.docker.com/r/bioconductor/release_cytometry2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/release_cytometry2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_cytometry2/) | [![](https://images.microbadger.com/badges/image/bioconductor/release_cytometry2:R3.6.0_Bioc3.9.svg)](https://hub.docker.com/r/bioconductor/release_cytometry2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/release_cytometry2.svg)](https://hub.docker.com/r/bioconductor/release_cytometry2/builds/)
| devel_cytometry2 ([GitHub](https://github.com/Bioconductor/bioc_docker/tree/master/out/devel_cytometry)) ([DockerHub](https://hub.docker.com/r/bioconductor/devel_cytometry2/)) | [![](https://images.microbadger.com/badges/version/bioconductor/devel_cytometry2.svg)](https://hub.docker.com/r/bioconductor/devel_cytometry2/) | [![](https://images.microbadger.com/badges/image/bioconductor/devel_cytometry2.svg)](https://hub.docker.com/r/bioconductor/devel_cytometry2/) | [![](https://img.shields.io/docker/cloud/build/bioconductor/devel_cytometry2.svg)](https://hub.docker.com/r/bioconductor/devel_cytometry2/builds/)

### General Docker Usage

A well organized guide to popular docker commands can be found
[here](https://github.com/wsargent/docker-cheat-sheet). For convenience, below
are some commands to get you started.
**Note:** You may need to add sudo before each command

##### List which docker machines are available locally
    docker images
##### List running containers
    docker ps
##### List all containers
    docker ps -a
##### Get container IP address
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' <name>
##### Get a copy of public docker
    docker pull <name>
##### Keep a container running at startup
    docker run -itd <name>
##### Shutdown container
    docker stop <name>
##### Resume container
    docker start <name>

##### Delete container
    docker rm <name>
##### Shell into a running container with either of the following:
    docker exec -it <name> /bin/bash
    docker attach <name>

##### Mount a volume

It is possible to mount/map an additional volume or directory. This might be
useful for say mounting a local R install directory for use on the docker. The
path on the docker image that should be mapped to the additional volume is
`/usr/local/lib/R/host-site-library`.  The follow example would mount my locally
installed packages to this docker directory. In turn, that path is automatically
loaded in the R `.libPaths` on the docker image and all of my locally installed
package would be available for use.

    sudo docker run -v /home/lori/R/x86_64-pc-linux-gnu-library/3.5-BioC-3.8:/usr/local/lib/R/host-site-library -it <name>  

##### User account

If running command line rather than with rstudio, please use the bioc user
account

    sudo docker run -ti --user bioc <name> R

##### Building and modifying the Bioconductor docker images

The BioC Dockerfiles are not directly edited. Instead,
for each biocView, there is a common `Dockerfile.in`,
from which two output files for `release` and `devel` files are generated by running
the `rake` command. All the creation is controlled by the `Rakefile`,
which will also take care if any of the dependencies (i.e. the *.in files) have changed.

E.g. the `Dockerfile` for the BioC development branch for core packages
is created from `src/core/Dockerfile.in` and placed into
`out/devel_core/Dockerfile`.


##### More Help

Please also see https://bioconductor.org/help/docker/
