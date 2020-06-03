# Ansible-lint Docker Container

A simple container to run ansible-lint, based on my general Ansible container [here](https://hub.docker.com/r/usmanatron/ansible).

## Usage

Running the container requires a volume mount from the containers `/ansible/playbooks` directory to your Ansible config. The recommended Ansible structure as set out [here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#directory-layout) is confirmed working, but other stuff should too.

Unlike the base Ansible container, everything should "Just Work" without any further manual effort.
