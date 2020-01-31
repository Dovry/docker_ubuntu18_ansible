FROM ubuntu:bionic
LABEL maintainer="Dovry"
ENV container=docker
ENV script_url "https://raw.githubusercontent.com/dovry/ansible-install-script/master/ansible_convenience_script.sh"

RUN apt-get update \
  && apt-get install -y --no-install-recommends wget \
  # Install ansible
  && wget --no-check-certificate $script_url \
  && chmod +x ansible_convenience_script.sh \
  && sh ./ansible_convenience_script.sh -p \
  && rm -f ansible_convenience_script.sh \
  # Cleanup
  && rm -rf /var/lib/apt/lists* \
  && apt-get clean

COPY initctl_faker .
RUN chmod +x initctl_faker \
  && rm -fr /sbin/initctl \
  && ln -s /initctl_faker /sbin/initctl

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
HEALTHCHECK CMD ansible --version