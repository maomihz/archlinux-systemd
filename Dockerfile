FROM maomihz/arch:latest

COPY pacman.d/ /etc/pacman.d/

RUN pacman -Sy --needed --noconfirm go
RUN pacman -S --needed --noconfirm ruby nodejs-lts-dubnium npm yarn
RUN pacman -S --needed --noconfirm aurutils yay
RUN pacman -S --needed --noconfirm oh-my-zsh-git pyenv \
    rbenv ruby-build-git nodenv nodenv-node-build-git

COPY --chown=cat:cat cat/ /home/cat/
RUN install -o cat -g cat -d /aur; \
    repo-add /aur/cat.db.tar.gz; \
    chmod 700 /home/cat/.{gnupg,ssh}; \
    chmod 600 /home/cat/.ssh/authorized_keys; \
    chmod +x /home/cat/setup.sh

# CMD ["/lib/systemd/systemd"]
CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
