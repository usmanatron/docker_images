FROM usmanatron/ansible:2.10.3

ARG ANSIBLE_LINT_VERSION

RUN set -x && \
    \
    echo "==> Installing ansible-lint"  && \
    pip install ansible-lint==${ANSIBLE_LINT_VERSION}

ENTRYPOINT ["ansible-lint"]