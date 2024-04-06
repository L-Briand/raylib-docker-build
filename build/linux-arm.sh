ARCH="linux-arm"
DOCKER_IMG="raylib/build-$ARCH"

[ -z "$RAYLIB_PATH" ] && RAYLIB_PATH=$(realpath raylib)
[ -z "$OUTPUT_PATH" ] && OUTPUT_PATH=$(realpath output)

mkdir -p "$OUTPUT_PATH"

if [ -z "$(docker images -q raylib/build-$ARCH 2> /dev/null)" ]; then
  docker build -t "$DOCKER_IMG" -f "build/linux/build-$ARCH.dockerfile" .
fi

docker run --rm -it \
  -v "./build/linux/RUN.sh:/run.sh" \
  -v "$RAYLIB_PATH:/raylib" \
  -v "$OUTPUT_PATH:/output" \
  "$DOCKER_IMG" \
  /run.sh -u "$(id -u "$USER")" -g "$(id -u "$USER")" -o "/output/$ARCH"

