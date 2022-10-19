FROM hadoop/base:latest

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD hadoop/namenode/run.sh /run.sh
RUN chmod a+x /run.sh

COPY lib/ /opt/hadoop-3.1.1/share/hadoop/common/lib/

EXPOSE 9870

CMD ["/run.sh"]
