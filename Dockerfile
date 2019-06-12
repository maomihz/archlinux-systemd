FROM maomihz/arch:build

WORKDIR /home/cat
RUN python-build 3.7.3 .pyenv/versions/3.7.3
RUN .pyenv/versions/3.7.3/bin/pip install jupyter jupyterlab --pre; \
    .pyenv/versions/3.7.3/bin/pip install -U pip

FROM maomihz/arch:build
WORKDIR /home/cat
COPY --from=0 /home/cat/.pyenv .pyenv
RUN chown -R cat:cat .pyenv
