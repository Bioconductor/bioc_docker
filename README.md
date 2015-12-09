For inforamtion about the available containers, installation and modification see the [Bioconductor Docker Page](http://bioconductor.org/help/docker/).

## General Docker Usage

### List which docker machines are available locally
    docker images
### List running containers
    docker ps
### List all containers
    docker ps -a
### Get container IP address
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' <name>
### Keep a container running at startup
    docker run -itd <name>
### Shutdown container
    docker stop <name>
### Resume container
    docker start <name>

### Delete container
    docker rm <name>
### Shell into a running container with either of the following:
    docker exec -it <name> /bin/bash
    docker attach <name>

