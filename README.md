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
