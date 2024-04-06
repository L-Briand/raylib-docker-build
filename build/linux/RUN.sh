#!/bin/bash
# This file is run inside running container to build raylib

while getopts "u:o:g:" opt; do
  case ${opt} in
    u) USER_ID=${OPTARG} ;;
    g) GROUP_ID=${OPTARG} ;;
    o) OUTPUT=${OPTARG} ;;
    \?) echo "Invalid option: -${OPTARG}" >&2 && exit ;;
  esac
done
shift $(( OPTIND - 1 ))


[ -z "${OUTPUT}" ] && echo "No output folder defined. Please add one with -o" && exit
cd /raylib/src || (echo "Failed to find /raylib/src folder" && exit)

make PLATFORM=PLATFORM_DESKTOP
mkdir -p "$OUTPUT"
cp libraylib.a raylib.h raymath.h rlgl.h "$OUTPUT"
chown -R $USER_ID:$GROUP_ID "$OUTPUT"
make clean

