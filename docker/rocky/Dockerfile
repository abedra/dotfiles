FROM rockylinux:9

RUN dnf install sudo -y

RUN useradd -ms /usr/bin/zsh appuser
RUN usermod -aG wheel appuser
RUN echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /home/appuser/dotfiles
RUN chown -R appuser:appuser /home/appuser

USER appuser
WORKDIR /home/appuser/dotfiles

COPY . .

RUN bash install.sh
WORKDIR /home/appuser
