FROM maomihz/arch:build

USER cat
RUN pyenv init -; rbenv init -
WORKDIR /home/cat/.pyenv/versions
RUN python-build 3.7.3 3.7.3
RUN python-build 2.7.16 2.7.16
RUN 3.7.3/bin/pip install jupyter jupyterlab --pre; \
    3.7.3/bin/pip install -U pip virtualenv; \
    2.7.16/bin/pip install -U pip virtualenv

FROM maomihz/arch:build
WORKDIR /home/cat
COPY --from=0 /home/cat/.pyenv .pyenv
COPY --from=0 /home/cat/.rbenv .rbenv
