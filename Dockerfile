FROM ubuntu:bionic
LABEL maintainer="Dovry"
ENV container=docker
ENV script_url "https://raw.githubusercontent.com/Dovry/ansible-install-script/master/ansible_convenience_script.sh"

RUN apt-get update \
  && apt-get install -y wget locales \
  # Install ansible
  && wget $script_url \
  && chmod +x ansible_convenience_script.sh \
  && bash ./ansible_convenience_script.sh \
  && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts \
  # Cleanup
  && rm -f ansible_convenience_script.sh \
  && rm -Rf /var/lib/apt/lists/* \
  && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
  && rm -rf /root/.cache/pip/ \
  && find / -name '*.pyc' -delete \
  && find / -name '*__pycache__*' -delete
  && apt-get clean

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
