FROM archlinux/base

COPY mirrorlist /etc/pacman.d/

RUN pacman -Syu --needed --noconfirm

RUN pacman -S --needed --noconfirm base base-devel systemd-resolvconf
RUN pacman -S --needed --noconfirm openssh supervisor curl wget zsh git vim tmux rsync
RUN pacman -S --needed --noconfirm go nodejs python python2

COPY supervisor.d/ /etc/supervisor.d/
COPY ssh/ /etc/ssh/
COPY sudoers.d/ /etc/sudoers.d/

RUN useradd -m -d /home/arch arch -s /usr/bin/zsh
RUN bash -c 'echo arch:arch | chpasswd'

RUN ln -sf /usr/lib/systemd/system/sshd.service /etc/systemd/system/multi-user.target.wants/sshd.service

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
