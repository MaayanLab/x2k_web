FROM node:22-bookworm AS builder

RUN set -x \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends unzip curl openjdk-17-jdk-headless \
  && rm -rf /var/lib/apt/lists/*

RUN \
  cd /usr/local && \
  curl -L https://services.gradle.org/distributions/gradle-8.0-bin.zip -o gradle-8.0-bin.zip && \
  unzip gradle-8.0-bin.zip && \
  rm gradle-8.0-bin.zip

ENV GRADLE_HOME=/usr/local/gradle-8.0
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

WORKDIR /work

ADD . .
RUN gradle war

FROM tomcat:9-jre21

RUN set -x \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get purge -y --auto-remove wget gnupg dirmngr gpg-agent gpgsm \
  && rm -rf /var/lib/apt/lists/* /usr/bin/pebble

COPY --from=builder /work/build/libs/work.war webapps/X2K.war
