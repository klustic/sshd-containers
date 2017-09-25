FROM ubuntu
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      net-tools \
      iproute2 \
      binutils \
      ltrace \
      strace \
      gdb \
      netcat
COPY src/lab01 /lab01
COPY docker/resources/in_container.sh /run.sh
CMD ["/bin/bash", "/run.sh"]
