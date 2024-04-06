FROM arm32v7/debian

# Necessary tools to build raylib as explained here:
# https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux
RUN <<EOF
apt update -y && apt install -y \
    build-essential git \
    libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev \
    libxinerama-dev libwayland-dev libxkbcommon-dev
EOF