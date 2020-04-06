# Docker Ubuntu 18.04 Ansible

![Build Status](https://github.com/dovry/docker_ubuntu18_ansible/workflows/Basic%20build%20and%20push%20to%20Docker%20hub/badge.svg)

![Docker Pulls](https://img.shields.io/docker/pulls/dovry/docker_ubuntu18_ansible)

Test Ansible roles in an Ubuntu 18.04 container

## How to use the container

```yaml
docker run --rm -d -it \
--name ubuntu18_ansible \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /run/lock:/run/lock:ro \
-v /etc/ansible:/etc/ansible:ro \
dovry/docker_ubuntu18_ansible:latest
```

And then either exec into the container and start hacking away with:

`docker exec -it ubuntu18_ansible /bin/bash`

or execute a role directly with a command such as this:

`docker exec -it ubuntu18_ansible ansible-playbook /etc/ansible/playbooks/test-role.yml`

Remember to set the target host in the playbook so that it is run in the container

`hosts: localhost`
