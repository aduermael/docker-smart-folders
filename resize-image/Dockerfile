FROM ubuntu:14.04

# install inotify tools and imagemagick
RUN apt-get update
RUN apt-get install inotify-tools imagemagick -y

COPY resize.bash /usr/local/bin
RUN chmod +x /usr/local/bin/resize.bash

EXPOSE 80

ENTRYPOINT ["resize.bash"]