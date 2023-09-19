FROM archlinux

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm sudo

RUN useradd -ms /usr/bin/zsh appuser
RUN usermod -aG wheel appuser
RUN echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER appuser
WORKDIR /home/appuser/dotfiles

COPY ../../. .

RUN bash install_linux.sh
WORKDIR /home/appuser
