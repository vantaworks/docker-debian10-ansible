FROM debian:stretch
LABEL maintainer="Robert Rice"

ENV DEBIAN_FRONTEND noninteractive

# Install `apt` dependencies + cleanup.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo \
       systemd \
       systemd-sysv \
       build-essential \
       ca-cacert \
       wget \
       libffi-dev \
       libssl-dev \
       python3-pip \
       python3-dev \
       python3-setuptools \
       python3-wheel \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc \
    && rm -Rf /usr/share/man \
    && apt-get clean

# Install `pip` dependencies
RUN pip3 install \
    wheel \
    cryptography \
    ansible \
    yamllint \
    ansible-lint \
    flake8 \
    testinfra \
    molecule

# Drop in (fake) init script
COPY initctl_faker .
RUN chmod +x initctl_faker \
    && rm -fr /sbin/initctl \
    && ln -s /initctl_faker /sbin/initctl

# Stub out a basic inventory
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
