# Generate/Compile a CMake contract project

This sample shows how to create a new C++ contract project based on CMake, and how to compile it.
The created project is visible from docker outside (the current directory is mounted inside the docker container), so you can work with it using your prefered tools.

## Syntax to initialize/compile the project

`
$ make [ init | [ build | clean] [PROJECT_NAME=<project name>] ]
`

- **init**: This target is only needed once. It will generate a new project in a subdirectory.
- **build**: Builds the generated Hello project
- **clean**: Cleans-up the build information

If the project name is not specified, *hello* will be used.
