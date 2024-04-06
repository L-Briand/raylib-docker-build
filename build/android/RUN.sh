#!/bin/bash
# This file is run inside running container to build raylib

while getopts "u:o:g:a:" opt; do
  case ${opt} in
    u) USER_ID=${OPTARG} ;;
    g) GROUP_ID=${OPTARG} ;;
    o) OUTPUT=${OPTARG} ;;
    a) ARCH=${OPTARG} ;;
    \?) echo "Invalid option: -${OPTARG}" >&2 && exit ;;
  esac
done
shift $(( OPTIND - 1 ))

[ -z "${OUTPUT}" ] && echo "No output folder defined. Please add one with -o" && exit
[ -z "${ARCH}" ] && echo "No architecture specified. Please add one with -a. Available: [arm, arm64, x86, x86_64]" && exit
if [ "arm" != "$ARCH" ] && [ "arm64" != "$ARCH" ] && [ "x86" != "$ARCH" ] && [ "x86_64" != "$ARCH" ] ; then
  echo "Unknown specified architecture '$ARCH'. Available: [arm, arm64, x86, x86_64]" && exit
fi

cd /raylib/src || (echo "Failed to find /raylib/src folder" && exit)

make PLATFORM=PLATFORM_ANDROID \
  ANDROID_NDK="/android-sdk/ndk/26.2.11394342" \
  ANDROID_ARCH="$ARCH"

mkdir -p "$OUTPUT"
cp libraylib.a raylib.h raymath.h rlgl.h "$OUTPUT"
chown -R $USER_ID:$GROUP_ID "$OUTPUT"
make clean

