FROM archlinux:base

RUN pacman-key --init
RUN pacman -Sy archlinux-keyring --noconfirm
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm sudo zsh

RUN useradd -ms /usr/bin/zsh appuser
RUN usermod -aG wheel appuser
RUN echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /home/appuser/dotfiles
RUN chown -R appuser:appuser /home/appuser

USER appuser
WORKDIR /home/appuser/dotfiles

COPY --chown=appuser:appuser . .

RUN bash install.sh
WORKDIR /home/appuser
