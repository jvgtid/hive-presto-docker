FROM hadoop/base:latest

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD hadoop/datanode/run.sh /run.sh
RUN chmod a+x /run.sh

COPY lib/ /opt/hadoop-3.1.1/share/hadoop/common/lib/

EXPOSE 9864

CMD ["/run.sh"]
