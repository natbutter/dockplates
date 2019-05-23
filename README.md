# Dockplates
### GPlates GUI in a Docker container

This Dockerfile installs an interactive GPLATES 2.1 instance.
GPlates uses open OpenGL, and if you have an NVIDIA card you need to allow the GUI forwarded through the X-Server/Host to run with the NVIDIA drivers. Hence, the seemingly weird choice of base image being from NVIDIA opengl. But this is a good general example for how to get any GUI based docker image running on your NVIDIA host.

If you make use of this image, please acknowledge the Sydney Informatics Hub at the University of Sydney [https://informatics.sydney.edu.au/](https://informatics.sydney.edu.au/)

### Build with:
```
sudo docker build . -t dockplates
```

### Run with:
```
sudo nvidia-docker run --rm -it -v `pwd`:/workspace -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY dockplates
```

I was getting errors building the the container because of wget 'Let's Encrypt' certificates, instead of figuring it out I just downloaded the source file first and then copy it to the container. So run this line to download the GPlates installer to your build directory first.

```
wget -O gplates.deb "https://downloads.sourceforge.net/project/gplates/gplates/2.1/gplates-ubuntu-bionic_2.1_1_amd64.deb"
```

More details about GPlates here:
[https://www.gplates.org/](https://www.gplates.org/)

From my old research group:
(https://www.earthbyte.org/](https://www.earthbyte.org/)
