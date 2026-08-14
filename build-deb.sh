#!/usr/bin/env bash

set -e

APP_NAME="youtube-downloader"
VERSION="1.1.0"
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

echo "FFmpeg : $FFMPEG_PATH"
echo "FFprobe: $FFPROBE_PATH"

# ============================================================
# Build PyInstaller
# ============================================================

echo
echo "Building PyInstaller..."

pyinstaller \
    --noconfirm \
    --clean \
    --onedir \
    --name "$APP_NAME" \
    --windowed \
    "$ROOT_DIR/main.py"

# ============================================================
# Add FFmpeg
# ============================================================

echo
echo "Bundling FFmpeg..."

mkdir -p "$PYINSTALLER_DIR/bin"

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
 Includes FFmpeg and FFprobe.
EOF

# ============================================================
# Build DEB
# ============================================================

OUTPUT="$ROOT_DIR/${APP_NAME}_${VERSION}_${ARCH}.deb"

dpkg-deb \
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
