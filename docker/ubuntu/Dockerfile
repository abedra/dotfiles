FROM ubuntu:22.04

RUN apt-get update -y
RUN apt-get install sudo -y

RUN useradd -ms /usr/bin/zsh appuser
RUN usermod -aG sudo appuser
RUN echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER appuser
WORKDIR /home/appuser/dotfiles

COPY ../../. .

RUN bash install_linux.sh
WORKDIR /home/appuser
