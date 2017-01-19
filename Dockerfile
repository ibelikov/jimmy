FROM jenkins

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root
RUN apt-get update && apt-get install -y python-pip

RUN mkdir -p /etc/jimmy
ADD sample/docker /etc/jimmy

VOLUME /etc/jimmy

RUN rm -rf /usr/share/jenkins/ref/init.groovy.d/*
COPY jimmy.groovy /usr/share/jenkins/ref/init.groovy.d/init-jimmy.groovy

RUN install-plugins.sh $(cat /etc/jimmy/plugins.txt | tr '\n' ' ')

COPY . /tmp/jimmy
RUN pip install /tmp/jimmy

USER jenkins

RUN mkdir -p "/var/jenkins_home/.ssh"
