
# YouTube Downloader GUI

A simple and lightweight YouTube downloader with a graphical user interface for Linux.

## 📦 Download

### Debian / Ubuntu

Download the latest `.deb` package:

**[⬇️ Download YouTube Downloader v1.2.0](https://github.com/saeidjeddi/YouTube-Downloader-GUI/releases/download/v1.2.0/youtube-downloader_1.2.0_amd64.deb)**

Or visit the [v1.2.0 Release](https://github.com/saeidjeddi/YouTube-Downloader-GUI/releases/tag/v1.2.0).

After downloading, install it with:

```shell
sudo apt install ./youtube-downloader_1.2.0_amd64.deb
```

## ⚙️ Requirements

The packaged application requires:

* FFmpeg
* Deno

Install them on Debian / Ubuntu:

```shell
sudo apt install ffmpeg
curl -fsSL https://deno.land/install.sh | sh
```

The app looks for Deno in this order:

1. `bin/deno` next to the packaged app
2. `PATH`
3. `~/.deno/bin/deno`

## 🚀 Run from source

Clone the repository:

```shell
git clone https://github.com/saeidjeddi/YouTube-Downloader-GUI.git
cd YouTube-Downloader-GUI
```

Create and activate a virtual environment:

```shell
python -m venv .venv
source .venv/bin/activate
```

Install dependencies:

```shell
pip install -r requirements.txt
```

Run the application:

```shell
python -m app.main
```

## 📥 Latest Release

**Version:** `v1.2.0`

**Download:** [youtube-downloader_1.2.0_amd64.deb](https://github.com/saeidjeddi/YouTube-Downloader-GUI/releases/download/v1.2.0/youtube-downloader_1.2.0_amd64.deb)

## 📄 License

See the repository for license information.
