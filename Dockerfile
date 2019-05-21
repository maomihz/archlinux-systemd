FROM archlinux/base

COPY pacman.d/ /etc/pacman.d/

RUN pacman -Syu --needed --noconfirm

RUN pacman -S --needed --noconfirm base-devel bash sudo coreutils shadow glibc
RUN pacman -S --needed --noconfirm openssh supervisor curl wget zsh git vim tmux rsync
RUN pacman -S --needed --noconfirm bind-tools net-tools psmisc
RUN pacman -S --needed --noconfirm python python2 ruby

# RUN pacman -S --needed --noconfirm go nodejs python python2

COPY etc/ /etc/

# Create users and set root password
RUN useradd -m -d /home/arch -G wheel -s /bin/bash -p '$6$JfBjSASkGi/JpuFI$Tu7D79OcRYP5wxG/jSRYlRFredPSrp9gh.Wn72OVoFuPb1Y5q5chK47rex7A8gLjU.WRQY0ce8.8pDnHq0w6n1' arch; \
    useradd -m -d /home/cat -G wheel -s /usr/bin/zsh -p '$6$7t5XlzsZbyhBCWn/$eoBoZMh5K6PbWWSBIZ4gyK4UHvnVRkaisqcqbc8piu6zWva9.bMHzyVowJq1eZwEcK.fHjfNc3rAWoBAamyRg.' cat; \
    usermod -p '$6$oYbUpO9p7rXcUVf/$BYWnyyUpxkAuWHWY/6nEDpkil/mNHSZjGe5ocQeni.HBBaLX8UhbTI0WfsI9u6vJXzLEekyCZqTm9e.fOFVDs0' root

RUN rm -f /etc/systemd/system/*.wants/*; \
    ln -sf /dev/null /etc/systemd/system/network.target; \
    ln -sf /dev/null /etc/systemd/system/systemd-timesyncd.service; \
    ln -sf /dev/null /etc/systemd/system/systemd-networkd.service; \
    ln -sf /dev/null /etc/systemd/system/systemd-resolved.service; \
    ln -sf /dev/null /etc/systemd/system/systemd-udevd.service; \
    ln -sf /dev/null /etc/systemd/system/systemd-udev-trigger.service; \
    ln -sf /dev/null /etc/systemd/system/dev-hugepages.mount; \
    ln -sf /dev/null /etc/systemd/system/tmp.mount; \
    ln -sf /usr/lib/systemd/system/sshd.service /etc/systemd/system/multi-user.target.wants/sshd.service

RUN sed -i '$ aInclude = /etc/pacman.d/maomihz-aur' /etc/pacman.conf; \
    chmod 600 /etc/ssh/ssh_host_*_key

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
