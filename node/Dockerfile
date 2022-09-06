FROM nervos/ckb:latest

USER root
RUN apt-get update

# curl, ps, awk and inotify commands
RUN apt-get install curl -y
RUN apt-get install procps -y
RUN apt-get install gawk -y

WORKDIR /home/nervos
ENV PATH="/home/nervos:${PATH}"
ADD ./init.sh .
ADD ./docker-entrypoint.sh .
ADD ./commands/* ./

USER ckb

WORKDIR /var/lib/ckb
