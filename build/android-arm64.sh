ARCH="android-arm64"
DOCKER_IMG="raylib/build-android"

[ -z "$RAYLIB_PATH" ] && RAYLIB_PATH=$(realpath raylib)
[ -z "$OUTPUT_PATH" ] && OUTPUT_PATH=$(realpath output)

mkdir -p "$OUTPUT_PATH"

if [ -z "$(docker images -q raylib/build-$ARCH 2> /dev/null)" ]; then
  docker build -t "$DOCKER_IMG" -f "build/android/build-android.dockerfile" .
fi

docker run --rm -it \
  -v "./build/android/RUN.sh:/run.sh" \
  -v "$RAYLIB_PATH:/raylib" \
  -v "$OUTPUT_PATH:/output" \
  "$DOCKER_IMG" \
  /run.sh -u "$(id -u "$USER")" -g "$(id -u "$USER")" -o "/output/$ARCH" -a "arm64"

