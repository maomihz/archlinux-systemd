FROM maomihz/arch:build

ENV PYENV_ROOT /home/cat/.pyenv
RUN pyenv install 3.7.3
RUN pyenv install 2.7.16

ENV RBENV_ROOT /home/cat/.rbenv
RUN rbenv install 2.6.3

RUN ${PYENV_ROOT}/versions/3.7.3/bin/pip  install jupyter jupyterlab --pre; \
    ${PYENV_ROOT}/versions/3.7.3/bin/pip  install -U pip virtualenv httpie; \
    ${PYENV_ROOT}/versions/2.7.16/bin/pip install -U pip virtualenv;

RUN ${RBENV_ROOT}/versions/2.6.3/bin/gem  install rails

RUN pyenv rehash; \
    rbenv rehash


FROM maomihz/arch:build
WORKDIR /home/cat
COPY --from=0 /home/cat/.pyenv .pyenv
COPY --from=0 /home/cat/.rbenv .rbenv
RUN chown -R cat:cat .pyenv .rbenv;
