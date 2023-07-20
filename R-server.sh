# Rstudio through Docker
rm -fr /workdir/jl3285/rstudio_dir

#On the host machine, create a local directory (any name) which would serve as rstudio session directory
mkdir /workdir/jl3285/rstudio_dir

# Start a Docker container R 4.2.1 using the image "rocker/rstudio" built by the Rocker project
#docker1 run  -d -e PASSWORD=2443435 -p 8009:8787 --name myrstudio rocker/rstudio:4.2.1 #-d = run docker in a daemon mode in background #--name = pick name for docker container 
docker1 run  -d -e PASSWORD=2443435 -p 8020:8787 rocker/rstudio:4.2.0 #-d = run docker in a daemon mode in background 

#get the docker id

docker1 ps
#docker container id: a96b9324c9dc

#Add your BioHPC user ID and primary group ID into Docker container and set passworkd

docker1 exec a96b9324c9dc groupadd -g `id -g` `id -g -n jl3285`
docker1 exec a96b9324c9dc useradd -m -u `id -u` -g `id -g ` -d /home/jl3285 jl3285
docker1 exec -it a96b9324c9dc passwd jl3285 #askes you the password and you have to type in : eg- 2443435

#make $USER as a sudo user in container
docker1 exec a96b9324c9dc usermod -aG sudo jl3285
 
#make an alias /home/$USER/.local that point to your local /workdir/jl3285/rstudio_dir #meaning???
docker1 exec --user jl3285 a96b9324c9dc ln -s /workdir/rstudio_dir /home/jl3285/.local #.local inside container

#ln -s : linux command create symbolic link.

#docker run will first download rocker/rstudio image, install and finally start R studio service.
# open a browser to access dockerized R studio at http://cbsudanko.biohpc.cornell.edu:8019 for linux system
#username and password: rstudio (default) or jl3285 and Yourpassword


#At this point, you might want to commit this container to a new image, so that you can re-use it later

docker1 commit a96b9324c9dc myrstudio

#you can also export to a portable image file so that you can use on any servers later

docker1 save -o myrstudio.tar biohpc_jl3285/myrstudio


#push to dockerhub
#tag the image : docker tag imageid docker.io/user-name/image-name:tag
docker1 tag biohpc_jl3285/myrstudio docker.io/norayuko/myrstudios #docker.io access the public biohpc repository
docker1 images
docker1 login -u norayuko docker.io
#Password:
#Login succeeded
docker1 push docker.io/norayuko/myrstudio

#If you need to load the tar file in your computer 
docker1 load -i myrstudio.tar #create images

#clean up
docker1 stop a96b9324c9dc
docker1 rm a96b9324c9dc
docker1 rmi <imageid>
docker1 clean 

docker1 claim




