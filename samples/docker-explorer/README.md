# Docker explorer

Just a simple way to explore the docker image via Bash or Midnight Commander

## Syntax

`
$ make [ explore-bash | explore-mc ]
`

## Points of interest

- **EOS installation for development**: /usr/local/eos  (`echo $EOSIO_ROOT`)
- **System contracts for unit tests**: /usr/local/src/eos/build/unittests/contracts (*) (`echo $EOSIO_CONTRACTS`)
- **CDT**: /usr/opt/eosio.cdt

(*) Be aware that the included system contracts are the legacy ones. They are generated at the blockchain compilation and are used but their unit tests (they can be useful for your unit tests). For new system contracts go to https://github.com/EOSIO/eosio.contracts

