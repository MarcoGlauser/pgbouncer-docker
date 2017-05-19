FROM ubuntu:16.04

RUN apt-get update && apt-get -y install wget
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
	apt-get update && \
	apt-get -y install pgbouncer

ENV PG_ENV_POSTGRESQL_MAX_CLIENT_CONN 1000
ENV PG_ENV_POSTGRESQL_DEFAULT_POOL_SIZE 100
ENV PG_ENV_POSTGRESQL_SERVER_IDLE_TIMEOUT 240
ENV PG_ENV_POSTGRESQL_POOL_MODE transaction
COPY run.sh /usr/local/bin/run

RUN chmod +x /usr/local/bin/run
EXPOSE 6432
CMD ["/usr/local/bin/run"]
