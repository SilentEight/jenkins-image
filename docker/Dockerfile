ARG jenkins_version=lts-slim
FROM jenkins/jenkins:${jenkins_version}

USER root

# Install Git and Git LFS
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        debian-archive-keyring \
        gnupg-agent \
        s-nail \
        wget \
    ; \
    rm -rf /var/lib/apt/lists/*

USER jenkins

# Preconfigure Jenkins
ENV TMPDIR ${JENKINS_HOME}/tmp
COPY plugins.txt /usr/share/jenkins/
COPY gitconfig /usr/share/jenkins/ref/.gitconfig
RUN set -eux; \
    jenkins-plugin-cli --plugins $(cat /usr/share/jenkins/plugins.txt | xargs); \
    echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state; \
    find /tmp -user jenkins -delete
