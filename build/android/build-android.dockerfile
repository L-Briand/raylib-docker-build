FROM  amd64/debian

# Necessary tools to build raylib as explained here:
# https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux
RUN <<EOF
apt update -y && apt install -y \
    build-essential git \
    libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev \
    libxinerama-dev libwayland-dev libxkbcommon-dev
EOF

RUN <<EOF
apt install -y wget unzip openjdk-17-jre

# Create android sdk folder
mkdir -p /android-sdk/cmdline-tools/latest/
export ANDROID_SDK_ROOT="/android-sdk"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"

# Download and extract command line tools
TEMP="$(mktemp -d)"
mkdir -p $TEMP && pushd $TEMP
wget -O cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip cmdline-tools.zip && rm cmdline-tools.zip
mv -v cmdline-tools/* "$ANDROID_SDK_ROOT/cmdline-tools/latest/"
popd
rm -fr $TEMP

# Install Android native dev kit
yes | sdkmanager --licenses
sdkmanager --install "ndk;26.2.11394342"
EOF