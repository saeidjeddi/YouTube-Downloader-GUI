# YouTube Downloader

A desktop YouTube downloader built with  **Python** ,  **PySide6** , and  **yt-dlp** .

The project provides a simple graphical interface for downloading YouTube videos and audio with configurable quality and format.

## Features

* 🎬 Download YouTube videos
* 🎵 Download audio only
* 📋 Support for YouTube video and playlist URLs
* 🎞️ Video quality selection:
* Best Available
* 4K
* 2K
* 1080p
* 720p
* 480p
* 360p
* 📦 Video formats:
* MP4
* MKV
* WEBM
* 🎧 Audio formats:
* MP3
* M4A
* WAV
* OPUS
* 🎚️ Audio quality:
* 128 kbps
* 192 kbps
* 256 kbps
* 320 kbps
* 📊 Download progress
* ⚡ Download speed display
* ⏱️ ETA display
* 📝 Download logs
* ⏹️ Stop download
* 🔄 Resume interrupted downloads
* 🧵 Background downloading using `QThread`
* 🎥 FFmpeg support
* 📁 Custom output directory

## Tech Stack

* **Python**
* **PySide6**
* **yt-dlp**
* **FFmpeg**

## Project Structure

<pre class="overflow-visible! px-0!" data-start="946" data-end="1441"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:0:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">youtube-downloader/</div><div class="cm-line">├── app/</div><div class="cm-line">│   ├── __init__.py</div><div class="cm-line">│   ├── main.py</div><div class="cm-line">│   │</div><div class="cm-line">│   ├── core/</div><div class="cm-line">│   │   ├── __init__.py</div><div class="cm-line">│   │   ├── config.py</div><div class="cm-line">│   │   └── ffmpeg.py</div><div class="cm-line">│   │</div><div class="cm-line">│   ├── downloader/</div><div class="cm-line">│   │   ├── __init__.py</div><div class="cm-line">│   │   ├── worker.py</div><div class="cm-line">│   │   ├── logger.py</div><div class="cm-line">│   │   └── options.py</div><div class="cm-line">│   │</div><div class="cm-line">│   └── ui/</div><div class="cm-line">│       ├── __init__.py</div><div class="cm-line">│       └── main_window.py</div><div class="cm-line">│</div><div class="cm-line">├── bin/</div><div class="cm-line">│   ├── ffmpeg</div><div class="cm-line">│   └── ffprobe</div><div class="cm-line">│</div><div class="cm-line">├── assets/</div><div class="cm-line">│   └── youtube-downloader.desktop</div><div class="cm-line">│</div><div class="cm-line">├── requirements.txt</div><div class="cm-line">├── build-deb.sh</div><div class="cm-line">└── README.md</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>



<p align="center">
  <img src="img/Screenshot From 2026-08-14 21-57-03.png" width="800">
</p>

## Requirements

* Python 3.10+
* PySide6
* yt-dlp
* FFmpeg
* FFprobe

## Installation

Clone the repository:

<pre class="overflow-visible! px-0!" data-start="1554" data-end="1653"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:1:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line"><span class="ͼ10">git</span> clone https://github.com/YOUR_USERNAME/youtube-downloader.git</div><div class="cm-line"><span class="ͼ10">cd</span> youtube-downloader</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

Create a virtual environment:

<pre class="overflow-visible! px-0!" data-start="1686" data-end="1719"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:2:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line">python3 <span class="ͼ12">-m</span> venv .venv</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

Activate it:

<pre class="overflow-visible! px-0!" data-start="1735" data-end="1772"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:3:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line"><span class="ͼ10">source</span> .venv/bin/activate</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

Install dependencies:

<pre class="overflow-visible! px-0!" data-start="1797" data-end="1840"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:4:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line">pip install <span class="ͼ12">-r</span> requirements.txt</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

## Run

Run the application as a Python module:

<pre class="overflow-visible! px-0!" data-start="1891" data-end="1921"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:5:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line">python <span class="ͼ12">-m</span> app.main</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

## FFmpeg

For development, the application can use FFmpeg available in the system:

<pre class="overflow-visible! px-0!" data-start="2008" data-end="2026"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:6:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">ffmpeg</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

For packaged builds, FFmpeg and FFprobe are expected under:

<pre class="overflow-visible! px-0!" data-start="2089" data-end="2128"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:7:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">bin/</div><div class="cm-line">├── ffmpeg</div><div class="cm-line">└── ffprobe</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

The application automatically detects the appropriate FFmpeg location.

## Download Modes

### Video

Select:

<pre class="overflow-visible! px-0!" data-start="2241" data-end="2265"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:8:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Type → Video</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

Then choose the desired:

<pre class="overflow-visible! px-0!" data-start="2293" data-end="2331"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:9:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Video Quality</div><div class="cm-line">Video Format</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

For example:

<pre class="overflow-visible! px-0!" data-start="2347" data-end="2368"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:10:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">1080p</div><div class="cm-line">MP4</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

### Audio

Select:

<pre class="overflow-visible! px-0!" data-start="2390" data-end="2419"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:11:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Type → Audio Only</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

Then choose:

<pre class="overflow-visible! px-0!" data-start="2435" data-end="2473"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:12:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Audio Format</div><div class="cm-line">Audio Quality</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

For example:

<pre class="overflow-visible! px-0!" data-start="2489" data-end="2513"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:13:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">MP3</div><div class="cm-line">192 kbps</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

## Output Structure

Downloaded files are organized using the playlist title:

<pre class="overflow-visible! px-0!" data-start="2594" data-end="2715"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:14:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Downloads/</div><div class="cm-line">└── Playlist Name/</div><div class="cm-line">    ├── 1 - Video One.mp4</div><div class="cm-line">    ├── 2 - Video Two.mp4</div><div class="cm-line">    └── 3 - Video Three.mp4</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

For a single video:

<pre class="overflow-visible! px-0!" data-start="2738" data-end="2799"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:15:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">Downloads/</div><div class="cm-line">└── Video/</div><div class="cm-line">    └── 1 - Video Title.mp4</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

## Linux Desktop

The project includes a desktop entry:

<pre class="overflow-visible! px-0!" data-start="2858" data-end="2903"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:16:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">assets/youtube-downloader.desktop</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

A Debian package build script is also included:

<pre class="overflow-visible! px-0!" data-start="2954" data-end="2980"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="relative h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class=""><div class="relative"><div class=""><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:17:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد" data-language="shell"><div class="cm-line">./build-deb.sh</div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></div></div></pre>

## Architecture

The project is separated into several modules:

### `app/core`

Application-level configuration and FFmpeg path handling.

### `app/downloader`

Download functionality based on `yt-dlp`.

<pre class="overflow-visible! px-0!" data-start="3187" data-end="3229"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:18:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">worker.py</div><div class="cm-line">logger.py</div><div class="cm-line">options.py</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

### `app/ui`

PySide6 graphical interface.

<pre class="overflow-visible! px-0!" data-start="3275" data-end="3301"><div class="relative w-full mt-4 mb-1"><div class=""><div class="contents"><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-(--code-block-surface) corner-superellipse/1.1 overflow-clip rounded-3xl [--code-block-surface:var(--bg-elevated-secondary)] dark:[--code-block-surface:var(--composer-surface-primary)] lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex h-full min-h-0 max-w-full"><div id="e2477393-655a-462f-9a69-2ffc1e57f8d4:19:editor" dir="ltr" class="Rx43rG_codemirror z-10 flex h-full min-h-0 w-full flex-col items-stretch"><div class="cm-editor ͼ1 ͼ3 ͼs ͼ16"><div class="cm-announced" aria-live="polite"></div><div tabindex="-1" class="cm-scroller"><div spellcheck="false" autocorrect="off" autocapitalize="off" writingsuggestions="false" translate="no" contenteditable="false" class="cm-content" role="textbox" aria-multiline="true" aria-readonly="true" aria-label="ویرایش کد"><div class="cm-line">main_window.py</div></div></div></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></div></pre>

### `app/main.py`

Application entry point.

## Disclaimer

This project is intended for downloading content that you have the right to download or that is otherwise permitted by the applicable terms and laws.

The project does not host or distribute downloaded content.

## License

This project is released under the  **MIT License** .

See the `LICENSE` file for details.
