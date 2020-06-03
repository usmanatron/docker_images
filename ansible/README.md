# Ansible Docker Container

A somewhat opinionated Ansible container.

## Usage

Running the container requires a volume mount from the containers `/ansible/playbooks` directory to your Ansible config. The recommended Ansible structure as set out [here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#directory-layout) is confirmed working, but other stuff should too.

## Opinions

### The entrypoint

Given the vast ways people can use Ansible, this container does **NOT** have it's own entrypoint.  Instead, it invokes the file at `/ansible/playbooks/docker/entrypoint.sh`. You have to either add this to your Ansible config or edit the entrypoint in the Docker container.

### Ansible Galaxy

The container supports having separate directories for self-authored and galaxy roles (`roles` and `roles_galaxy` resp.). This will work out of the box.
