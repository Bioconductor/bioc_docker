Update After Release
====================

**Important:**
Before going any further, 

1. Disable the Build Setting feature on dockerhub for [bioconductor/devel_base2](https://hub.docker.com/r/bioconductor/devel_base2/~/settings/automated-builds/). This ensures no random builds clogging docker hub occur.  The box next to `When active, builds will happen automatically on pushes` should be UNCHECKED

2. If this is the release cycle that is not using the development version of R, unlink the rocker/rstudio-daily dockerhub repository in the section for `Repository Links`. 



### Make one last **Release** build with old version of R and Bioc 

A. In Local checkout of GitHub repository bioc_docker:

1. Change the config.yml for the release version, the parent should specify the
version specific tag for rstudio.  <See https://hub.docker.com/r/rocker/rstudio/tags/>
```
versions: 
    release:
        parent: "rocker/rstudio:<specific version tag>
```
2. Manually delete 
```
rm out/release_base/Dockerfile
```
3. `Rake` the directory and make sure the out/release_base/Dockerfile was updated. 

4. Commit and push to GitHub
5. Create a Github tag for the specific version 
```
git tag -a R3.4.0_Bioc3.5_v2 -m "build at end of cycle"
git push origin R3.4.0_Bioc3.5_v2
```

B. Now Switch to <https://github.com/Bioconductor/bioc_docker> 

1. create a new branch for the version : R3.4.0_Bioc3.5_v2

C. Now Go to dockerhub 

1. Go to: [release_base2](https://hub.docker.com/r/bioconductor/release_base2/~/settings/automated-builds/) 

2. Change the Docker Tag Name to appropriate new versions **Important:** After changing the name don't forget to `Save Changes` BEFORE Triggering a Build

3.  Trigger the Build by selecting `Trigger` next to the line with the updated version tag.  You shouldn't have to trigger the `latest` build, it should do this automatically. If it doesn't then trigger manually.  It is important that there be a build for both the version specific and the latest tag.  

4.  View progress [here](https://hub.docker.com/r/bioconductor/release_base2/builds/)

5. Repeat C. 1-4 for [release_core2](https://hub.docker.com/r/bioconductor/release_core2/~/settings/automated-builds/)


### Make new build for release and devel with new versions

A. In Local checkout of GitHub repository bioc_docker:

1. Change the config.yml. Follow the instructions in the file for determining values for release and devel.  

2. Manually delete files in out/release_base and out/devel_base (the rake will not update if they are already created).  Both the Dockerfile and the install scripts must be deleted. 

3. `rake` the directory and ensure the new Docker and install scripts were generated. 

4. Commit and push to Github

5. Create new tags and push to github (see above step: Create a Github tag for the specific version for format)

B. Now Switch to <https://github.com/Bioconductor/bioc_docker> 

1. create a new branch for the version : R3.4.0_Bioc3.6

C. Now Go to dockerhub 

1. Go to: [release_base2](https://hub.docker.com/r/bioconductor/release_base2/~/settings/automated-builds/) 

2. Change the Docker Tag Name to appropriate new versions **Important:** After changing the name don't forget to `Save Changes` BEFORE Triggering a Build

3.  Trigger the Build by selecting `Trigger` next to the line with the updated version tag.  You shouldn't have to trigger the `latest` build, it should do this automatically. If it doesn't then trigger manually.  It is important that there be a build for both the version specific and the latest tag.  

4.  View progress [here](https://hub.docker.com/r/bioconductor/release_base2/builds/)

5. Repeat C. 1-4 for [release_core2](https://hub.docker.com/r/bioconductor/release_core2/~/settings/automated-builds/)

6. **Important** Reinitialize the  Build Setting feature on dockerhub for [bioconductor/devel_base2](https://hub.docker.com/r/bioconductor/devel_base2/~/settings/automated-builds/). The box next to `When active, builds will happen automatically on pushes` should be CHECKED!

D. On your local version of Github/bioc_docker

1. Run the following: 
```
dateTag=`date +%Y%m%d`
git tag -a $dateTag -m "test tagging"
git push origin $dateTag
```

E. Back on dockerHub

1. Ensure the autobuild is enabled. After the previous step a build should have been triggered [here](https://hub.docker.com/r/bioconductor/devel_base2/builds/). 

2. If this is the release cycle that is using the development version of R, link the  rocker/rstudio-daily dockerhub repository on [this page](https://hub.docker.com/r/bioconductor/devel_base2/~/settings/automated-builds/). There is a section for `Repository Links`. 

3. The rest of the devel builds should trigger automatically as all the resositories are linked.  

4.  Manually Build any release dockers from other contributors. It is assumed the devel ones will be updated automatically as they should be linked to at the very least the devel_base2 package. 