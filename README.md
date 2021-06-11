
# libblank


---------------------------------------------------------------------
## Table of contents

* [Introduction](#introduction)
* [Quick Start](#quick-start)
* [Administration](#administration)
* [Using in your project](#using-in-your-project)
* [Build Dependencies](#build-dependencies)
* [Library Dependencies](#library-dependencies)
* [Extensions](#extensions)
* [References](#references)
* [API Reference](annotated.html)

&nbsp;


---------------------------------------------------------------------
## Introduction

This is a library template project.  Check this project out, then use
it to make your own project by running **rename.sh**.

    $ ./rename.sh <project-name> <namespace>

### Example

    $ ./rename.sh libmycoolstuff mcs

This example will create a project at the same level as libblank called
libmycoolstuff.  Customize as you like.

&nbsp;


---------------------------------------------------------------------
## Quick Start

### Windows

---------------------------------------------------------------------

- Install [CMake](https://cmake.org/download/)
- Install [Visual Studio](https://visualstudio.microsoft.com/downloads/).
  *The free **Community Edition** is fine*

Build project with cmake

    > cmake . -B ./bld -G "Visual Studio 16 2019"
    > cmake --build ./bld -j8 --config Release

For the shell scripts below to work, you will need to install the
[Windows Sybsystem for Linux(WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

When using Windows, do not type ./ before the shell script.
So for instance, to add the `pip` extension, type...

    > add.sh pip

### Linux

---------------------------------------------------------------------

You can build and install the library with cmake using

    $ cmake . -B ./bld  -G "Unix Makefiles"
    $ cmake --build ./bld
    $ sudo cmake --install ./bld

View help

    $ libblank help

Cleanup build files

    $ ./clean.sh

Uninstall

    $ sudo libblank uninstall


If you prefer to install using a deb package

    $ cpack -B ./pck --config ./bld/CPackConfig.cmake -G DEB -C Release
    $ sudo apt install ./pck/libblank-0.1.0-Linux.deb

Uninstall deb package

    $ sudo apt remove libblank


Run tests in docker image

    $ docker build -t libblank-test -f ./prv/test/Dockerfile .

&nbsp;


---------------------------------------------------------------------
## Administration

Library commands, for once you have it installed

- Display help

    **$ libblank help**

- Uninstall

    **$ sudo libblank uninstall**

- Show installation roots

    **$ libblank files**

- Get installation information.  (Change this info in **PROJECT.txt**)

    **$ libblank info \<variable\>**

    variable = One of [name, description, url, version, build, company, author, lib, include, bin, share]

&nbsp;


---------------------------------------------------------------------
## Using in your project

To Include this library in your project.

    #include <libblank.h>

You also need to add the linker option `-lblank`

If you prefer, you can use pkg-config

    pkg-config --cflags libblank
    pkg-config --libs libblank

&nbsp;


---------------------------------------------------------------------
## Build Dependencies

### CMake

    apt-get -yq update
    apt-get -yq install build-essential cmake doxygen


&nbsp;


---------------------------------------------------------------------
## Library Dependencies

*NONE*

&nbsp;


---------------------------------------------------------------------
## Extensions

To add extensions, run

    ./add.sh <extension>

*Running this command again will restore missing files without overwriting*


Available extensions are

Extension     | Description
------------- | ----------
cmake         | The default cmake files.
conan         | The conan build system.
docker        | Support for docker build.
gradle        | Building with gradle. Gradle support is minimal at this time.
pip           | Support for pip module
npm           | Support for making an npm module.

&nbsp;

---------------------------------------------------------------------
### [CMake](https://cmake.org)

    ./add.sh cmake

This will restore the default cmake project files under `./src`.

#### Configure

    $ cmake . -B ./bld  -G "Unix Makefiles"

#### Build

    $ cmake --build ./bld

#### Install

    $ sudo cmake --install ./bld

#### Uninstall

    $ sudo libblank uninstall

&nbsp;

---------------------------------------------------------------------
### [Conan](https://conan.io)

    $ ./add.sh conan

Adds support for the Conan packaging system.

#### Install Conan and dependencies on debian

    $ sudo apt-get -yq install python3 python3-pip
    $ python3 -m pip install conan

#### Configure

    $ conan install .

#### Build

    $ conan build .

#### Make Package

    $ conan package .

#### Install deb package

    $ sudo apt install ./package/libblank-0.1-Linux.deb

#### Uninstall deb package

    $ sudo apt remove libblank

&nbsp;

---------------------------------------------------------------------
### [Gradle](https://gradle.org)

    $ ./add.sh gradle

*Gradle support is currently minimal, some features are not available, but it should get you started*

#### Configure / build

    $ gradle build

&nbsp;

---------------------------------------------------------------------
### [Docker](https://docs.docker.com/engine/install)

    $ ./add.sh docker

Adds a basic docker file and setup script.

#### Build

    $ docker build -t libblank

#### Run

    $ docker run -it libblank

&nbsp;

---------------------------------------------------------------------
### [pip](https://pip.pypa.io/en/stable)

    $ ./add.sh pip

Add support for building python modules and packaging with pip.

#### Install python / pip on debian

    $ sudo apt-get -yq install python3 python3-pip python11-dev

#### Install

    $ pip3 install .

#### Uninstall

    $ pip3 uninstall -y libblank

&nbsp;

---------------------------------------------------------------------
### [npm](https://docs.npmjs.com)

    $ ./add.sh npm

Adds support for node.js modules and npm packaging system

#### Install node.js and npm on debian

    $ sudo apt install git nodejs npm

The first time you will need to build using cmake to create a package.json file.
Or you could create one manually

    $ cmake . -B ./bld
    $ cmake --build ./bld


Once you have a package.json file, you can just use npm

#### Build

    $ npm install

#### Build / install locally

    $ npm link

#### Uninstall

    $ npm rm libblank -g


---------------------------------------------------------------------
## References

- CMake
    - https://cmake.org

- Conan
    - https://conan.io

- Docker
    - https://docs.docker.com

- Gradle
    - https://gradle.org

- Doxygen
    - https://www.doxygen.nl

- pip
    - https://pip.pypa.io/en/stable/

- npm
    - https://docs.npmjs.com/

