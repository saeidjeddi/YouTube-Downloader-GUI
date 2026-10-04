#!/usr/bin/env bash

set -e

APP_NAME="youtube-downloader"
VERSION="1.2.0"
ARCH="amd64"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BUILD_DIR="$ROOT_DIR/build"
DIST_DIR="$ROOT_DIR/dist"
PACKAGE_DIR="$BUILD_DIR/${APP_NAME}_${VERSION}_${ARCH}"

PYINSTALLER_DIR="$DIST_DIR/$APP_NAME"

echo "======================================"
echo " Building $APP_NAME v$VERSION"
echo "======================================"

# ============================================================
# Clean
# ============================================================

rm -rf "$BUILD_DIR"
rm -rf "$DIST_DIR"

mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"

# ============================================================
# Check FFmpeg
# ============================================================

FFMPEG_PATH="$(command -v ffmpeg || true)"
FFPROBE_PATH="$(command -v ffprobe || true)"

if [[ -z "$FFMPEG_PATH" ]]; then
    echo "ERROR: ffmpeg not found."
    exit 1
fi

if [[ -z "$FFPROBE_PATH" ]]; then
    echo "ERROR: ffprobe not found."
    exit 1
fi

DENO_PATH="$(command -v deno || true)"

if [[ -z "$DENO_PATH" ]]; then
    echo "ERROR: deno not found."
    echo "yt-dlp needs a JavaScript runtime to download from YouTube."
    echo "Install it with: curl -fsSL https://deno.land/install.sh | sh"
    exit 1
fi

echo "FFmpeg : $FFMPEG_PATH"
echo "FFprobe: $FFPROBE_PATH"
echo "Deno   : $DENO_PATH"

# ============================================================
# Build PyInstaller
# ============================================================

echo
echo "Building PyInstaller..."

# The code lives in the `app` package (imports are `from app...`), so
# PyInstaller is pointed at a tiny launcher and told where to find `app`.
#
# Two layouts are supported:
#   1. <root>/app/main.py   -> the repository layout
#   2. <root>/main.py       -> this folder itself is the package, so it
#                              must be named "app"
if [[ -f "$ROOT_DIR/app/main.py" ]]; then
    PKG_PARENT="$ROOT_DIR"
elif [[ -f "$ROOT_DIR/main.py" ]]; then
    if [[ "$(basename "$ROOT_DIR")" != "app" ]]; then
        echo "ERROR: main.py imports 'app.*', so this folder must be named 'app'."
        exit 1
    fi
    PKG_PARENT="$(dirname "$ROOT_DIR")"
else
    echo "ERROR: could not find app/main.py or main.py next to build-deb.sh."
    exit 1
fi

cat > "$BUILD_DIR/launcher.py" <<'EOF'
from app.main import main

if __name__ == "__main__":
    main()
EOF

pyinstaller \
    --noconfirm \
    --clean \
    --onedir \
    --name "$APP_NAME" \
    --windowed \
    --paths "$PKG_PARENT" \
    --distpath "$DIST_DIR" \
    --workpath "$BUILD_DIR/pyinstaller" \
    --specpath "$BUILD_DIR" \
    --collect-all yt_dlp_ejs \
    "$BUILD_DIR/launcher.py"

# ============================================================
# Add FFmpeg
# ============================================================

echo
echo "Bundling FFmpeg and Deno..."

mkdir -p "$PYINSTALLER_DIR/bin"

cp "$DENO_PATH" \
   "$PYINSTALLER_DIR/bin/deno"

chmod +x \
    "$PYINSTALLER_DIR/bin/deno"

cp "$FFMPEG_PATH" \
   "$PYINSTALLER_DIR/bin/ffmpeg"

cp "$FFPROBE_PATH" \
   "$PYINSTALLER_DIR/bin/ffprobe"

chmod +x \
    "$PYINSTALLER_DIR/bin/ffmpeg"

chmod +x \
    "$PYINSTALLER_DIR/bin/ffprobe"

# ============================================================
# Test bundled files
# ============================================================

if [[ ! -f "$PYINSTALLER_DIR/bin/ffmpeg" ]]; then
    echo "ERROR: FFmpeg was not bundled."
    exit 1
fi

if [[ ! -f "$PYINSTALLER_DIR/bin/ffprobe" ]]; then
    echo "ERROR: FFprobe was not bundled."
    exit 1
fi

if [[ ! -f "$PYINSTALLER_DIR/bin/deno" ]]; then
    echo "ERROR: Deno was not bundled."
    exit 1
fi

# ============================================================
# Create Debian package
# ============================================================

echo
echo "Creating Debian package..."

mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/opt/$APP_NAME"
mkdir -p "$PACKAGE_DIR/usr/bin"
mkdir -p "$PACKAGE_DIR/usr/share/applications"
mkdir -p "$PACKAGE_DIR/usr/share/icons/hicolor/256x256/apps"

# ============================================================
# Copy application
# ============================================================

cp -a "$PYINSTALLER_DIR/." \
    "$PACKAGE_DIR/opt/$APP_NAME/"

# ============================================================
# Launcher
# ============================================================

cat > "$PACKAGE_DIR/usr/bin/$APP_NAME" <<EOF
#!/bin/sh

exec /opt/$APP_NAME/$APP_NAME "\$@"
EOF

chmod +x "$PACKAGE_DIR/usr/bin/$APP_NAME"

# ============================================================
# Desktop Entry
# ============================================================

cat > "$PACKAGE_DIR/usr/share/applications/$APP_NAME.desktop" <<EOF
[Desktop Entry]
Name=YouTube Downloader
Comment=Download videos and audio using yt-dlp
Exec=$APP_NAME
Terminal=false
Type=Application
Categories=AudioVideo;Network;
StartupNotify=true
EOF

# ============================================================
# Debian Control
# ============================================================

cat > "$PACKAGE_DIR/DEBIAN/control" <<EOF
Package: $APP_NAME
Version: $VERSION
Section: video
Priority: optional
Architecture: $ARCH
Maintainer: Saeid Jeddi
Depends: libc6
Description: YouTube Downloader
 A desktop YouTube downloader built with Python, PySide6 and yt-dlp.
 Includes FFmpeg, FFprobe and Deno.
EOF

# ============================================================
# Build DEB
# ============================================================

OUTPUT="$ROOT_DIR/${APP_NAME}_${VERSION}_${ARCH}.deb"

dpkg-deb \
    --root-owner-group \
    --build \
    "$PACKAGE_DIR" \
    "$OUTPUT"

# ============================================================
# Done
# ============================================================

echo
echo "======================================"
echo " Build completed successfully"
echo "======================================"

echo
echo "Package:"
echo "$OUTPUT"

echo
echo "Size:"
du -h "$OUTPUT"

echo
echo "Contents:"
dpkg-deb -c "$OUTPUT" | head -40

echo
echo "======================================"
