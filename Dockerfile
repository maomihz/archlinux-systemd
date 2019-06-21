FROM maomihz/arch:build

USER cat
RUN pyenv init -; rbenv init -
WORKDIR /home/cat/
RUN python-build 3.7.3  .pyenv/versions/3.7.3
RUN python-build 2.7.16 .pyenv/versions/2.7.16
RUN ruby-build   2.6.3  .rbenv/versions/2.6.3
RUN .pyenv/versions/3.7.3/bin/pip  install jupyter jupyterlab --pre; \
    .pyenv/versions/3.7.3/bin/pip  install -U pip virtualenv httpie; \
    .pyenv/versions/2.7.16/bin/pip install -U pip virtualenv; \
    .rbenv/versions/2.6.3/bin/gem  install rails; \
    .pyenv/bin/pyenv rehash; \
    .rbenv/bin/rbenv rehash



FROM maomihz/arch:build
WORKDIR /home/cat
COPY --from=0 /home/cat/.pyenv .pyenv
COPY --from=0 /home/cat/.rbenv .rbenv
RUN chown -R cat:cat .pyenv .rbenv;
