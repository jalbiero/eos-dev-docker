# Nodeos usage

This simple example shows how to run a non producer node using the development docker.

The node can be configured via the following files:

- [eosio/nodeos/config/config.ini](./eosio/nodeos/config/config.ini)
- [eosio/nodeos/config/genesis.json](./eosio/nodeos/config/genesis.json)
- [eosio/nodeos/config/protocol_features/*.json](./eosio/nodeos/config/protocol_features)

## Syntax

`
$ make [ start | start-detached | stop | tail-detached-logs ]
`

- **start**: Starts a non producer node (CTRL+C to quit/stop)
- **start-detached**: Starts a non producer node in background
- **stop**: Stops a running node
- **tail-detached-logs**: Follows the logs of a detached node
