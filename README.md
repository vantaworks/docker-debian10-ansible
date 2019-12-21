Ansible Test Image - Debian 10 (Buster)
=======================================
This Docker container serves as a isolated testing environment for the development of Ansible roles and Playbooks and is part of a suite Docker images for that purpose. The primary use case is for [Molecule](https://molecule.readthedocs.io/en/stable/) testing. __It is not intended for production applications__.  

Included Ansible developement tools
* yamllint
* ansible-lint
* flake8
* testinfra
* molecule

Manual Build
------------
Upstream images will be provided automatically; however, for manual builds, the only pre-requisite is Docker installed on your system and a local checkout of this repo.

1. `cd` to you local checkout of this repo
2. Run `docker build -t ddocker-debian10-ansible .`

Usage
-----

These steps are only required if manual, one-off testing is used.

1. Pull the image (skip if you manually built it): `docker pull vantaworks/docker-debian10-ansible:latest`
2. Run the container:

```
docker run --detach --privileged \
  --name docker-debian10-ansible \
  --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
  --volume=`pwd`:/etc/ansible/roles/<role_under_test>:ro \
  vantaworks/docker-debian10-ansible:latest
```

_Replace `<role_under_test>` with the name of your role._

3. Execute `ansible-playbook` thusly: 
```
docker exec -it docker-debian10-ansible \
  env TERM=xterm \
  ansible-playbook /path/to/ansible/playbook.yml \
  --syntax-check
```

Recommendations
---------------
For Playbook Testing: I highly recommend looking into [Molecule](https://molecule.readthedocs.io/en/stable/)

Credits
-------
Huge thanks to [Jeff Geerling](https://github.com/geerlingguy), which much of this repo's content is inspired by.
