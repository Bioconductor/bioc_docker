#!/bin/bash

## Set defaults for environmental variables in case they are undefined
USER=${USER:=rstudio}
PASSWORD=${PASSWORD:=rstudio}
EMAIL=${EMAIL:=rstudio@example.com}
USERID=${USERID:=1000}
ROOT=${ROOT:=FALSE}

## Configure user account name and password (used by rstudio)
#useradd -m $USER -u $USERID 
echo "$USER:$PASSWORD" | chpasswd
## User must own their home directory, or RStudio won't be able to load
## (Note this is only necessary if the user is linking a shared volume to a subdir of this directory)
#mkdir /home/$USER 

chown $USER:$USER /home/$USER

## Let user write to /usr/local/lib/R/site.library
## addgroup $USER staff

# Use Env flag to know if user should be added to sudoers
if [ "$ROOT" == "TRUE" ]; then
  adduser $USER sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
fi

echo "library(BiocInstaller)" > /home/$USER/.Rprofile
