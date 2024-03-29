# Compile a simple smart contract sample

This is a minimal contract from the following official tutorial:

https://developers.eos.io/welcome/latest/getting-started-guide/hello-world

You can start a new bash session inside a docker container and follow the tutorial (see below) or you can just compile the file via the provided Makefile without dealing with docker management directives.

## Syntax to compile the contract

`
$ make [ build | clean | bash ]
`

- **build**: Builds the hello smart contract 
- **clean**: cleans-up the build information
- **bash**: Opens an interactive bash session inside a docker container. The current directory is mounted inside the container.
