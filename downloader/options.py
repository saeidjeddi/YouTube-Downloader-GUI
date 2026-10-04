from app.core.ffmpeg import get_ffmpeg_path
from app.core.jsruntime import get_js_runtimes
from app.downloader.logger import YTDLPLogger


def build_options(
    worker,
    output_dir,
    mode,
    video_quality,
    video_format,
    audio_quality,
    audio_format,
    format_id,
    output_template,
):

    options = {
        "format": format_id,
        "outtmpl": output_template,
        "noplaylist": False,
        # Skip an item whose download fails (e.g. a transient HTTP 403)
        # instead of aborting the whole playlist. Failures are reported
        # through the return code, see DownloadWorker.run().
        "ignoreerrors": "only_download",
        # Be gentle with YouTube to reduce HTTP 429 / 403 on long playlists.
        "sleep_interval_requests": 1,
        "sleep_interval": 2,
        "max_sleep_interval": 5,
        "retries": 5,
        "fragment_retries": 5,
        "extractor_retries": 5,
        "socket_timeout": 30,
        "nooverwrites": True,
        "continuedl": True,
        "nopart": False,
        "addmetadata": True,
        "verbose": True,
        "logger": YTDLPLogger(worker),
        "progress_hooks": [worker.progress_hook],
        # Allow yt-dlp to download the EJS challenge solver if the
        # bundled yt-dlp-ejs package is missing or outdated.
        "remote_components": ["ejs:github"],
        # The default android_vr client returns googlevideo URLs that answer
        # HTTP 403 without a PO token. mweb / web_embedded download fine.
        "extractor_args": {
            "youtube": {
                "player_client": ["mweb", "web_embedded"],
            },
        },
    }

    ffmpeg_location = get_ffmpeg_path()

    if ffmpeg_location:
        options["ffmpeg_location"] = ffmpeg_location

    js_runtimes = get_js_runtimes()

    if js_runtimes:
        options["js_runtimes"] = js_runtimes

    if mode == "audio":

        if audio_format == "mp3":

            options["postprocessors"] = [
                {
                    "key": "FFmpegExtractAudio",
                    "preferredcodec": "mp3",
                    "preferredquality": str(audio_quality),
                }
            ]

        elif audio_format == "m4a":

            options["postprocessors"] = [
                {
                    "key": "FFmpegExtractAudio",
                    "preferredcodec": "m4a",
                    "preferredquality": str(audio_quality),
                }
            ]

        elif audio_format == "wav":

            options["postprocessors"] = [
                {
                    "key": "FFmpegExtractAudio",
                    "preferredcodec": "wav",
                }
            ]

        elif audio_format == "opus":

            options["postprocessors"] = [
                {
                    "key": "FFmpegExtractAudio",
                    "preferredcodec": "opus",
                    "preferredquality": str(audio_quality),
                }
            ]

    else:

        if video_format == "mp4":

            options["merge_output_format"] = "mp4"

        elif video_format == "mkv":

            options["merge_output_format"] = "mkv"

        elif video_format == "webm":

            options["merge_output_format"] = "webm"

    return options
