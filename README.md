Repository archived, new location: https://codeberg.org/jalbiero/eos-dev-docker
---

# eos-dev-docker
Development docker for [EOSIO Blockchain](https://github.com/EOSIO) smart contracts

## Instructions
The provided *Makefile* can build and push (to Docker Hub) a development docker
image for EOS. The image will contains everything you need to build and test
a smart contract:

- [EOS blockchain node](https://github.com/EOSIO/eos)
- [EOSIO.CDT](https://github.com/EOSIO/eosio.cdt)
- [Boost.Test](https://www.boost.org/doc/libs/1_71_0/libs/test/doc/html/index.html)
- Native clang 7 compiler (with lldb-7)
- Make
- CMake
- Vim
- Midnight Commander
- Git

For more information about **FETCH_ALL** parameter see comments inside *Makefile*

```bash
make [ build-image [ FETCH_ALL=1 ] | push-image ]

```

## Samples
[Here some small projects that show the docker usage](./samples/README.md)

## Note

I was commited to maintain this docker project, but the roadmap of EOS is unknown to me. I don't understand what is going on with the blockchain:

1. The [EOS repository](https://github.com/EOSIO/eos) was archived on August 2, 2022. It is mentioned on Internet that its replacement will be *Mandel*.
2. The [Mandel repository](https://github.com/eosnetworkfoundation/mandel) says that Mandel contains an archived version of the protocol which in turn, was replaced by the new implementation, *Leap*.
3. The [Leap repository](https://github.com/AntelopeIO/leap) which does not belong to EOS Foundation, has new instructions to build the blockchain. 

Until somebody starts using Leap I won't try to build the development docker.
