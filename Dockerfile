#Dockerfile to install an interactive GPLATES 2.1 instance
#This uses OpenGL and if you have an NVIDIA card you will
#need to allow the GUI to run on the NVIDIA drivers.
#Hence, the weird choice of base image being from NVIDIA opengl.
#If you make use of this image, please acknoledge 
#Sydney Informatics Hub at the University of Sydney
#https://informatics.sydney.edu.au/

#Build with:
#sudo docker build . -t dockplates

#Run with:
#sudo nvidia-docker run --rm -it -v `pwd`:/workspace -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY dockplates

FROM nvidia/opengl:1.0-glvnd-devel

LABEL maintainer="nathaniel.butterworth@sydney.edu.au"

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         wget

#Install pre-reqs
RUN apt-get install -y --no-install-recommends python-dev libboost-dev libboost-python-dev libboost-thread-dev libboost-program-options-dev libboost-test-dev libboost-system-dev libcgal-dev libproj-dev libqwt-dev libfreetype6-dev libfontconfig1-dev libice-dev libsm-dev

RUN apt-get install -y --no-install-recommends libqt4-dev libgdal-dev 
RUN apt-get install -y --no-install-recommends libglew-dev
RUN apt-get install -y --no-install-recommends libglu1-mesa

#Create a workspace
WORKDIR /workspace

#This doesn't work in the container because of wget Let's Encrypt certificates, instead of figuring it out I just downloaded it first and then copy it to the container
#RUN wget -O gplates-ubuntu-xenial_2.1_1_amd64.deb "https://downloads.sourceforge.net/project/gplates/gplates/2.1/gplates-ubuntu-xenial_2.1_1_amd64.deb"
COPY gplates-ubuntu-xenial_2.1_1_amd64.deb /workspace
RUN dpkg -i gplates-ubuntu-xenial_2.1_1_amd64.deb 

#Make the workspace read/write
RUN chmod -R a+w /workspace

#Run GPlates
CMD gplates
