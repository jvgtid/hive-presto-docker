FROM openjdk:8u181-jre-stretch

LABEL MAINTAINER=shawnzhu@users.noreply.github.com

ENV PRESTO_VERSION=0.261
ENV PRESTO_HOME=/home/presto

# Add source due debian stretch move to archive.debian.org/
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

# extra dependency for running launcher
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
		python2.7-minimal vim && \
    ln -s /usr/bin/python2.7 /usr/bin/python

RUN groupadd -g 999 presto && \
    useradd -r -u 999 -g presto --create-home --shell /bin/bash presto
USER presto

RUN curl -L https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz -o /tmp/presto-server.tgz && \
    tar -xzf /tmp/presto-server.tgz --strip 1 -C ${PRESTO_HOME} && \
    mkdir -p ${PRESTO_HOME}/data && \
    rm -f /tmp/presto-server.tgz

#RUN curl -L https://github.com/IBM/presto-db2/releases/download/${PRESTO_VERSION}/presto-db2-${PRESTO_VERSION}.zip -o /tmp/presto-db2.zip && \
#    unzip /tmp/presto-db2.zip -d ${PRESTO_HOME}/plugin/ && \
#    mv ${PRESTO_HOME}/plugin/presto-db2-${PRESTO_VERSION} ${PRESTO_HOME}/plugin/db2 && \
#    rm -f /tmp/presto-db2.zip

RUN curl -L http://www.congiu.net/hive-json-serde/1.3.8/hdp23/json-serde-1.3.8-jar-with-dependencies.jar -o ${PRESTO_HOME}/plugin/hive-hadoop2/json-serde-1.3.8-jar-with-dependencies.jar

COPY prestodb/etc ${PRESTO_HOME}/etc
COPY prestodb/ss-presto-plugins ${PRESTO_HOME}/plugin/ss-presto-plugins

COPY .env ${PRESTO_HOME}/.env

RUN . ${PRESTO_HOME}/.env && echo "hive.s3.aws-access-key=${AWS_ACCESS_KEY_ID}" >> ${PRESTO_HOME}/etc/catalog/hive.properties
RUN . ${PRESTO_HOME}/.env && echo "hive.s3.aws-secret-key=${AWS_SECRET_ACCESS_KEY}" >> ${PRESTO_HOME}/etc/catalog/hive.properties

EXPOSE 8080

COPY lib/ /opt/hadoop-3.1.1/share/hadoop/common/lib/

VOLUME ["${PRESTO_HOME}/data"]

WORKDIR ${PRESTO_HOME}

ENTRYPOINT ["./bin/launcher"]

CMD ["run"]
