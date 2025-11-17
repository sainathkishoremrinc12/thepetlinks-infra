# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

FROM docker.io/bitnami/minideb:bookworm

ARG TARGETARCH
LABEL org.opencontainers.image.title="Kafka (Bitnami KRaft custom)" \
      org.opencontainers.image.version="4.1.1"

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_FLAVOUR="debian-12" \
    OS_NAME="linux"

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

# --------------------------------------------------------------------
# 1. System + Java
# --------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y ca-certificates curl procps zlib1g openjdk-17-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------------------------
# 2. Add Kafka 4.1.1 binaries
# --------------------------------------------------------------------
RUN mkdir -p /opt/bitnami/kafka && \
    curl -fsSL https://downloads.apache.org/kafka/4.1.1/kafka_2.13-4.1.1.tgz \
    -o /tmp/kafka.tgz && \
    tar -xzf /tmp/kafka.tgz -C /opt/bitnami/kafka && \
    rm /tmp/kafka.tgz

# --------------------------------------------------------------------
# 3. Prepare environment
# --------------------------------------------------------------------
ENV APP_VERSION="4.1.1" \
    BITNAMI_APP_NAME="kafka" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/kafka/kafka_2.13-4.1.1/bin:$PATH"

WORKDIR /opt/bitnami/kafka/kafka_2.13-4.1.1
EXPOSE 9092

# --------------------------------------------------------------------
# 4. Create default KRaft config
# --------------------------------------------------------------------
RUN mkdir -p config/kraft && \
    cat > config/kraft/server.properties <<'EOF'
process.roles=broker,controller
node.id=1
controller.quorum.voters=1@localhost:9093
listeners=PLAINTEXT://:9092,CONTROLLER://:9093
advertised.listeners=PLAINTEXT://localhost:9092
controller.listener.names=CONTROLLER
listener.security.protocol.map=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
log.dirs=/tmp/kraft-combined-logs
num.partitions=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
group.initial.rebalance.delay.ms=0
EOF

# --------------------------------------------------------------------
# 5. Auto-start Kafka in KRaft mode
# --------------------------------------------------------------------
CMD ["/bin/bash", "-c", "\
mkdir -p /tmp/kraft-combined-logs && \
CLUSTER_ID=$(./bin/kafka-storage.sh random-uuid) && \
./bin/kafka-storage.sh format --config ./config/kraft/server.properties \
  --cluster-id $CLUSTER_ID --ignore-formatted && \
exec ./bin/kafka-server-start.sh ./config/kraft/server.properties"]

