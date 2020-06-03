FROM usmanatron/ansible:2.9.5

ARG ANSIBLE-LINT_VERSION

RUN set -x && \
    \
    echo "==> Installing ansible-lint"  && \
    pip install ansible-lint==${ANSIBLE-LINT_VERSION}

ENTRYPOINT ["ansible-lint"]