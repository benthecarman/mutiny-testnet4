# mutiny-testnet4

This repo contains a deployment of the Mutiny Wallet for testnet4.

The main deployment is done with docker-compose. It contains various services:

* [bitcoind](https://github.com/bitcoin/bitcoin)
* [lnd](https://github.com/lightningnetwork/lnd)
* [rgs server](https://github.com/lightningdevkit/rapid-gossip-sync-server)
* [VSS](https://github.com/mutinywallet/vss-rs)
* [proxy](https://github.com/MutinyWallet/ln-websocket-proxy)
* [web](https://github.com/MutinyWallet/mutiny-wasm)

A lot of these required small modifications to work with testnet4.

## Setup

For the rapid-gossip-sync-server, you need to set the `LN_PEERS` variable properly. You can have it connect to the deployed lnd instance by running:

```bash
docker exec -it lnd /bin/lncli -n testnet getinfo | jq -r '.identity_pubkey'
```

This will print the node id of the deployed lnd instance. You can then set the `LN_PEERS` variable to this value with the trailing `@lnd:9735` part.

You'll also want to connect this lightning node to any other known testnet4 nodes if available.

## Running

To run the deployment, you need to have docker and docker-compose installed. Then you can run:

```bash
docker-compose up -d
```

This will start all the services. You can check the logs with:

```bash
docker-compose logs -f
```

You can also run the services individually:

```bash
docker-compose up -d bitcoind lnd rgs_server
```

You can create some aliases to make it easier to interact with bitcoind and lnd:

```bash
alias lncli="docker exec -it lnd /bin/lncli -n testnet"
alias bitcoin-cli="docker exec -it bitcoind /usr/local/bin/bitcoin-cli -testnet4"
```

## Updating

To update the deployment, you can run:

```bash
git pull
docker-compose pull
```

And then restart the services:

```bash
docker-compose up -d
```
