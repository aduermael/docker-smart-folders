FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install imagemagick -y

COPY resize.bash /usr/local/bin
RUN chmod +x /usr/local/bin/resize.bash

ENTRYPOINT ["resize.bash"]