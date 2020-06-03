# Based on https://github.com/walokra/docker-ansible-playbook/blob/master/Dockerfile
FROM alpine:3.11.3

ARG ANSIBLE_VERSION

ENV BUILD_PACKAGES \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  python3 \
  py3-boto \
  py3-dateutil \
  py3-httplib2 \
  py3-jinja2 \
  py3-paramiko \
  py3-yaml \
  ca-certificates


RUN set -x && \
    \
    echo "==> Adding build-dependencies..."  && \
    apk --update add --virtual build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      openssl-dev \
      python3-dev && \
    \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..."  && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    if [[ ! -e /usr/bin/pip ]]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip install --upgrade pip && \
    pip install python-keyczar docker-py && \
    \
    echo "==> Installing Ansible..."  && \
    pip install ansible==${ANSIBLE_VERSION} && \
    \
    echo "==> Cleaning up..."  && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=false \
    ANSIBLE_RETRY_FILES_ENABLED=false \
    ANSIBLE_ROLES_PATH=/ansible/playbooks/roles_galaxy:/ansible/playbooks/roles \
    ANSIBLE_SSH_PIPELINING=True \
    PATH=/ansible/bin:$PATH \
    ANSIBLE_LIBRARY=/ansible/library

WORKDIR /ansible/playbooks
VOLUME "/ansible/playbooks"

ENTRYPOINT ["/ansible/playbooks/docker/entrypoint.sh"]