#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================================
# Configuration
# ============================================================

APP_NAME="youtube-downloader"
APP_DISPLAY_NAME="YouTube Downloader"
VERSION="1.2.0"
ARCH="amd64"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BUILD_DIR="$ROOT_DIR/build"
DIST_DIR="$ROOT_DIR/dist"

PACKAGE_NAME="${APP_NAME}_${VERSION}_${ARCH}"
PACKAGE_DIR="$BUILD_DIR/$PACKAGE_NAME"

PYINSTALLER_DIR="$DIST_DIR/$APP_NAME"

OUTPUT="$ROOT_DIR/${PACKAGE_NAME}.deb"

# Application icon.
#
# Recommended:
#   assets/youtube-downloader.png
#
# PNG should ideally be 256x256 or larger.
ICON_SOURCE="$ROOT_DIR/assets/youtube-downloader.png"

ICON_DIR="$PACKAGE_DIR/usr/share/icons/hicolor/256x256/apps"
ICON_TARGET="$ICON_DIR/$APP_NAME.png"

DESKTOP_DIR="$PACKAGE_DIR/usr/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/$APP_NAME.desktop"

LAUNCHER_DIR="$PACKAGE_DIR/usr/bin"
LAUNCHER_FILE="$LAUNCHER_DIR/$APP_NAME"

# ============================================================
# Helpers
# ============================================================

log() {
    echo
    echo "==> $*"
}

error() {
    echo
    echo "ERROR: $*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

cleanup() {
    if [[ "${KEEP_BUILD:-0}" != "1" ]]; then
        rm -rf "$BUILD_DIR"
        rm -rf "$DIST_DIR"
    fi
}

trap 'echo; echo "ERROR: Build failed at line $LINENO."; exit 1' ERR

# ============================================================
# Header
# ============================================================

echo "============================================================"
echo " Building $APP_DISPLAY_NAME"
echo " Version : $VERSION"
echo " Arch    : $ARCH"
echo "============================================================"

# ============================================================
# Check required commands
# ============================================================

log "Checking required commands..."

REQUIRED_COMMANDS=(
    python3
    pyinstaller
    dpkg-deb
    ffmpeg
    ffprobe
    deno
)

for command in "${REQUIRED_COMMANDS[@]}"; do
    if ! command_exists "$command"; then
        error "'$command' was not found in PATH."
    fi
done

echo "Python    : $(command -v python3)"
echo "PyInstaller: $(command -v pyinstaller)"
echo "FFmpeg    : $(command -v ffmpeg)"
echo "FFprobe   : $(command -v ffprobe)"
echo "Deno      : $(command -v deno)"
echo "dpkg-deb  : $(command -v dpkg-deb)"

# ============================================================
# Resolve external binaries
# ============================================================

FFMPEG_PATH="$(command -v ffmpeg)"
FFPROBE_PATH="$(command -v ffprobe)"
DENO_PATH="$(command -v deno)"

# ============================================================
# Validate project structure
# ============================================================

log "Checking project structure..."

if [[ -f "$ROOT_DIR/app/main.py" ]]; then

    PKG_PARENT="$ROOT_DIR"

elif [[ -f "$ROOT_DIR/main.py" ]]; then

    if [[ "$(basename "$ROOT_DIR")" != "app" ]]; then
        error "main.py imports 'app.*', but this directory is not named 'app'."
    fi

    PKG_PARENT="$(dirname "$ROOT_DIR")"

else

    error "Could not find app/main.py or main.py."
fi

echo "Package root: $PKG_PARENT"

# ============================================================
# Validate icon
# ============================================================

log "Checking application icon..."

if [[ ! -f "$ICON_SOURCE" ]]; then
    error "Application icon not found:

$ICON_SOURCE

Create the icon at:

assets/youtube-downloader.png

Recommended size: 256x256 PNG."
fi

if [[ ! -r "$ICON_SOURCE" ]]; then
    error "Application icon is not readable:

$ICON_SOURCE"
fi

echo "Icon: $ICON_SOURCE"

# ============================================================
# Clean
# ============================================================

log "Cleaning previous build..."

rm -rf "$BUILD_DIR"
rm -rf "$DIST_DIR"

rm -f "$OUTPUT"

mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"

# ============================================================
# Prepare PyInstaller launcher
# ============================================================

log "Preparing PyInstaller launcher..."

LAUNCHER_SOURCE="$BUILD_DIR/launcher.py"

cat > "$LAUNCHER_SOURCE" <<'PYTHON'
from app.main import main


if __name__ == "__main__":
    main()
PYTHON

# ============================================================
# Build PyInstaller
# ============================================================

log "Building PyInstaller application..."

PYINSTALLER_ARGS=(
    --noconfirm
    --clean
    --onedir
    --name "$APP_NAME"
    --windowed

    --paths "$PKG_PARENT"

    --distpath "$DIST_DIR"
    --workpath "$BUILD_DIR/pyinstaller"
    --specpath "$BUILD_DIR"

    --collect-all yt_dlp_ejs
)

# PyInstaller supports PNG as an application icon.
#
# This also makes the executable itself carry the icon where
# supported by the platform.
PYINSTALLER_ARGS+=(
    --icon "$ICON_SOURCE"
)

pyinstaller \
    "${PYINSTALLER_ARGS[@]}" \
    "$LAUNCHER_SOURCE"

# ============================================================
# Validate PyInstaller output
# ============================================================

log "Validating PyInstaller output..."

if [[ ! -d "$PYINSTALLER_DIR" ]]; then
    error "PyInstaller output directory was not created:

$PYINSTALLER_DIR"
fi

if [[ ! -x "$PYINSTALLER_DIR/$APP_NAME" ]]; then
    error "PyInstaller executable was not created:

$PYINSTALLER_DIR/$APP_NAME"
fi

echo "PyInstaller output: OK"

# ============================================================
# Bundle FFmpeg / FFprobe / Deno
# ============================================================

log "Bundling FFmpeg, FFprobe and Deno..."

BIN_DIR="$PYINSTALLER_DIR/bin"

mkdir -p "$BIN_DIR"

cp "$FFMPEG_PATH" "$BIN_DIR/ffmpeg"
cp "$FFPROBE_PATH" "$BIN_DIR/ffprobe"
cp "$DENO_PATH" "$BIN_DIR/deno"

chmod +x \
    "$BIN_DIR/ffmpeg" \
    "$BIN_DIR/ffprobe" \
    "$BIN_DIR/deno"

# ============================================================
# Validate bundled binaries
# ============================================================

log "Validating bundled binaries..."

for binary in ffmpeg ffprobe deno; do

    FILE="$BIN_DIR/$binary"

    if [[ ! -f "$FILE" ]]; then
        error "Bundled binary not found:

$FILE"
    fi

    if [[ ! -x "$FILE" ]]; then
        error "Bundled binary is not executable:

$FILE"
    fi

    echo "$binary: OK"
done

# ============================================================
# Create Debian package structure
# ============================================================

log "Creating Debian package structure..."

mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/opt/$APP_NAME"
mkdir -p "$LAUNCHER_DIR"
mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"

# ============================================================
# Copy application
# ============================================================

log "Copying application..."

cp -a \
    "$PYINSTALLER_DIR/." \
    "$PACKAGE_DIR/opt/$APP_NAME/"

# ============================================================
# Install application icon
# ============================================================

log "Installing application icon..."

cp "$ICON_SOURCE" "$ICON_TARGET"

chmod 644 "$ICON_TARGET"

if [[ ! -f "$ICON_TARGET" ]]; then
    error "Failed to install application icon."
fi

echo "Installed:"
echo "$ICON_TARGET"

# ============================================================
# Create system launcher
# ============================================================

log "Creating launcher..."

cat > "$LAUNCHER_FILE" <<EOF
#!/bin/sh
exec /opt/$APP_NAME/$APP_NAME "\$@"
EOF

chmod 755 "$LAUNCHER_FILE"

# ============================================================
# Create Desktop Entry
# ============================================================

log "Creating desktop entry..."

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_DISPLAY_NAME
Comment=Download videos and audio using yt-dlp
Exec=$APP_NAME
Icon=$APP_NAME
Terminal=false
Type=Application
Categories=AudioVideo;Network;
StartupNotify=true
EOF

chmod 644 "$DESKTOP_FILE"

# ============================================================
# Validate Desktop Entry
# ============================================================

log "Validating desktop entry..."

if [[ ! -f "$DESKTOP_FILE" ]]; then
    error "Desktop entry was not created."
fi

if ! grep -q "^Icon=$APP_NAME$" "$DESKTOP_FILE"; then
    error "Desktop entry does not contain the expected Icon entry."
fi

if ! grep -q "^Exec=$APP_NAME$" "$DESKTOP_FILE"; then
    error "Desktop entry does not contain the expected Exec entry."
fi

echo "Desktop entry: OK"

# ============================================================
# Debian control file
# ============================================================

log "Creating Debian control file..."

cat > "$PACKAGE_DIR/DEBIAN/control" <<EOF
Package: $APP_NAME
Version: $VERSION
Section: video
Priority: optional
Architecture: $ARCH
Maintainer: Saeid Jeddi
Depends: libc6
Description: $APP_DISPLAY_NAME
 A desktop YouTube downloader built with Python, PySide6 and yt-dlp.
 Includes FFmpeg, FFprobe and Deno.
EOF

chmod 644 "$PACKAGE_DIR/DEBIAN/control"

# ============================================================
# Show package structure before build
# ============================================================

log "Package structure..."

find "$PACKAGE_DIR" \
    -type f \
    -printf '%P\n' \
    | sort

# ============================================================
# Build Debian package
# ============================================================

log "Building Debian package..."

dpkg-deb \
    --root-owner-group \
    --build \
    "$PACKAGE_DIR" \
    "$OUTPUT"

# ============================================================
# Validate generated DEB
# ============================================================

log "Validating generated package..."

if [[ ! -f "$OUTPUT" ]]; then
    error "DEB package was not created."
fi

# Verify Debian package metadata.
dpkg-deb --info "$OUTPUT" >/dev/null

# Verify important files exist inside package.
if ! dpkg-deb --contents "$OUTPUT" | grep -q \
    "./usr/share/applications/$APP_NAME.desktop"; then

    error "Desktop entry is missing from DEB."
fi

if ! dpkg-deb --contents "$OUTPUT" | grep -q \
    "./usr/share/icons/hicolor/256x256/apps/$APP_NAME.png"; then

    error "Application icon is missing from DEB."
fi

if ! dpkg-deb --contents "$OUTPUT" | grep -q \
    "./opt/$APP_NAME/$APP_NAME"; then

    error "Application executable is missing from DEB."
fi

# ============================================================
# Package information
# ============================================================

log "Package information"

echo
dpkg-deb --info "$OUTPUT"

echo
echo "Package size:"
du -h "$OUTPUT"

echo
echo "Important package files:"
dpkg-deb --contents "$OUTPUT" \
    | grep -E \
    "usr/share/applications|usr/share/icons|/opt/$APP_NAME/$APP_NAME|usr/bin/$APP_NAME"

# ============================================================
# Cleanup
# ============================================================

if [[ "${KEEP_BUILD:-0}" != "1" ]]; then

    log "Cleaning temporary build files..."

    rm -rf "$BUILD_DIR"
    rm -rf "$DIST_DIR"

else

    echo
    echo "KEEP_BUILD=1"
    echo "Build directories were preserved:"
    echo "$BUILD_DIR"
    echo "$DIST_DIR"

fi

# ============================================================
# Done
# ============================================================

echo
echo "============================================================"
echo " Build completed successfully"
echo "============================================================"
echo
echo "Application : $APP_DISPLAY_NAME"
echo "Version     : $VERSION"
echo "Architecture: $ARCH"
echo
echo "DEB package:"
echo "$OUTPUT"
echo
echo "Install with:"
echo
echo "  sudo apt install \"$OUTPUT\""
echo
echo "Or:"
echo
echo "  sudo dpkg -i \"$OUTPUT\""
echo
echo "============================================================"