# 🎬 YouTube Downloader

![License](https://img.shields.io/badge/license-MIT-blue.svg)

A modern desktop YouTube downloader built with **Python**, **PySide6**, and **yt-dlp**.

This application provides a simple graphical interface for downloading YouTube videos and audio with different qualities and formats.

<p align="center">
  <img src="img/Screenshot From 2026-08-14 21-57-03.png" width="800">
</p>

## ✨ Features

- 🎬 Download YouTube videos
- 🎵 Download audio only
- 📋 Support YouTube playlists
- 🎞️ Video quality selection:

  - Best Available
  - 4K
  - 2K
  - 1080p
  - 720p
  - 480p
  - 360p
- 📦 Video formats:

  - MP4
  - MKV
  - WEBM
- 🎧 Audio formats:

  - MP3
  - M4A
  - WAV
  - OPUS
- 🎧 Audio quality: 128 / 192 / 256 / 320 kbps
- 📊 Download progress
- ⚡ Download speed display
- ⏱️ ETA display
- ⏹️ Stop download
- 🔄 Resume interrupted downloads (already downloaded files are skipped)
- 🛟 A failed item does not abort the whole playlist
- 🧵 Background downloading with QThread
- 📁 Custom output directory
- 🎥 FFmpeg integration

## 📋 Requirements

| Tool                                   | Why it is needed                                                  |
| -------------------------------------- | ----------------------------------------------------------------- |
| **Python**                       | Tested with Python 3.14                                           |
| **FFmpeg** and **FFprobe** | Merging video + audio, audio conversion                           |
| **Deno**                         | JavaScript runtime that yt-dlp uses to solve YouTube's challenges |

Python packages are listed in [`requirements.txt`](requirements.txt) (they include `yt-dlp[default]`, which pulls in the `yt-dlp-ejs` solver scripts).

### Install FFmpeg and Deno (Debian / Ubuntu)

```bash
sudo apt install ffmpeg
curl -fsSL https://deno.land/install.sh | sh
```

The app looks for Deno in this order: next to the packaged app (`bin/deno`), on your `PATH`, then `~/.deno/bin/deno`.

## 🚀 Run from source

```bash
git clone https://github.com/saeidjeddi/YouTube-Downloader-GUI.git
cd YouTube-Downloader-GUI

python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

python -m app.main
```

> Run the command from the **project root** (the folder that contains `app/`), using `-m`.
> Running `python main.py` from inside `app/` fails with `ModuleNotFoundError: No module named 'app'`.

## 📁 Output

Files are saved to the folder you choose (default: `~/Downloads`):

```
<output folder>/<playlist title, or "Video">/<index> - <title>.<ext>
```

## 🩺 Troubleshooting

**`ModuleNotFoundError: No module named 'app'`**
Run `python -m app.main` from the project root, not from inside `app/`.

**`You have requested merging of multiple formats but ffmpeg is not installed`**
Install FFmpeg and make sure `ffmpeg` and `ffprobe` are on your `PATH` (`which ffmpeg ffprobe`).

**`No supported JavaScript runtime could be found`**
Install Deno (see [Requirements](#-requirements)). The log line `JS runtimes: deno-...` confirms it was found.

**`HTTP Error 403: Forbidden` while downloading**
The app requests YouTube through the `mweb` and `web_embedded` clients, because the default `android_vr` client returned 403 for the tested videos. If a single item still fails, it is skipped and the app reports "Finished with errors". Run the same URL again: items that already finished are skipped and only the failed ones are retried. If it keeps failing, YouTube may be rate limiting your IP (an `HTTP Error 429` in the log is a hint), so wait a while or try again later.

**`Finished with errors`**
At least one item failed. Read the log in the app window for the reason, then run again to retry them.

For anything else, the log panel in the app shows full `yt-dlp` debug output. Include it when you report a problem.

## 🛠 Tech Stack

- Python
- PySide6
- yt-dlp
- FFmpeg
- Deno

## ⚖️ Disclaimer

Only download content you have the right to download. You are responsible for following YouTube's Terms of Service and the copyright laws that apply to you.

## 📄 License

Released under the [MIT License](LICENSE).
