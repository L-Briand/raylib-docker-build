# Raylib BuildScripts

Docker scripts to build static [raylib](https://www.raylib.com/) `libraylib.a` files for different platforms.

There is no one for all script that build everything, macOS releases still need to be built on macOS.
However, some can be built with docker, and that's what this repository does.

In most cases, you do not want generic builds. Use the dockerfiles to create your own.

## Setup

Clone this repository and init `raylib` submodule

```shell
git submodule init
git -C raylib checkout 5.0 # use latest tag on github
```

Install [docker engine](https://docs.docker.com/engine/install/) and qemu on your computer. You can find more
information on the docker [multi-platform image](https://docs.docker.com/build/building/multi-platform/) page.
For me on Ubuntu 23.10 I needed to install apt packages: `qemu-user`, `qemu-user-binfmt` and `qemu-system-arm`, reboot
and I was able to run foreign platforms (`docker run --rm -it --platform linux/arm/v7 debian:latest bash`).

## Building

If you want to learn how to build yourself, there are tutorials and information in
the [raylib wiki](https://github.com/raysan5/raylib/wiki). I believe there are ways to cross-compile without having
emulated docker containers, but I'm too lazy for that.

From the root directory run one of the script `build/<platform>-<arch>.sh`. (like `build/android-arm.sh`)

Then a new file `output/android-arm/libraylib.a` is build. You can check the architecture of the generated file with:

```
$ readelf -h output/android-arm/libraylib.a | grep '^Cass\|File\|Machine'
File: ../output/linux-arm32/libraylib.a(rcore.o)
  Class:                             ELF32
  Machine:                           ARM
[...]
```

