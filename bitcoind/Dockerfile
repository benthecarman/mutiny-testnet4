FROM debian:bullseye-slim as builder

ARG BITCOIN_VERSION="28.0rc1"
ARG TRIPLET=${TRIPLET:-"x86_64-linux-gnu"}

RUN apt-get update && \
    apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu wget libc6 procps python3
WORKDIR /tmp

# install bitcoin binaries
RUN BITCOIN_URL="https://bitcoincore.org/bin/bitcoin-core-28.0/test.rc1/bitcoin-${BITCOIN_VERSION}-${TRIPLET}.tar.gz" && \
    BITCOIN_FILE="bitcoin-${BITCOIN_VERSION}-${TRIPLET}.tar.gz" && \
    wget -qO "${BITCOIN_FILE}" "${BITCOIN_URL}" && \
    mkdir -p bin && \
    tar -xzvf "${BITCOIN_FILE}" -C /tmp/bin --strip-components=2 "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-cli" "bitcoin-${BITCOIN_VERSION}/bin/bitcoind" "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-wallet" "bitcoin-${BITCOIN_VERSION}/bin/bitcoin-util"

FROM debian:bullseye-slim as runner

ENV BITCOIN_DIR /root/.bitcoin
COPY --from=builder "/tmp/bin" /usr/local/bin

VOLUME $BITCOIN_DIR

# REST interface
EXPOSE 8080

# P2P network (mainnet, testnet & regnet respectively)
EXPOSE 8333 18333 18444

# RPC interface (mainnet, testnet & regnet respectively)
EXPOSE 8332 18332 18443

# ZMQ ports (for transactions & blocks respectively)
EXPOSE 28332 28333

ENTRYPOINT ["bitcoind"]

CMD ["-zmqpubrawblock=tcp://0.0.0.0:28332", "-zmqpubrawtx=tcp://0.0.0.0:28333"]