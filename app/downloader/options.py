from app.core.ffmpeg import get_ffmpeg_path
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

        "ffmpeg_location":
            get_ffmpeg_path(),

        "outtmpl":
            output_template,

        "noplaylist":
            False,

        "ignoreerrors":
            False,

        "retries":
            5,

        "fragment_retries":
            5,

        "extractor_retries":
            5,

        "socket_timeout":
            10,

        "nooverwrites":
            True,

        "continuedl":
            True,

        "nopart":
            False,

        "addmetadata":
            True,

        "verbose":
            True,

        "logger":
            YTDLPLogger(worker),

        "progress_hooks": [
            worker.progress_hook
        ],
    }

    if mode == "audio":

        if audio_format == "mp3":

            options["postprocessors"] = [
                {
                    "key":
                        "FFmpegExtractAudio",

                    "preferredcodec":
                        "mp3",

                    "preferredquality":
                        str(
                            audio_quality
                        ),
                }
            ]

        elif audio_format == "m4a":

            options["postprocessors"] = [
                {
                    "key":
                        "FFmpegExtractAudio",

                    "preferredcodec":
                        "m4a",

                    "preferredquality":
                        str(
                            audio_quality
                        ),
                }
            ]

        elif audio_format == "wav":

            options["postprocessors"] = [
                {
                    "key":
                        "FFmpegExtractAudio",

                    "preferredcodec":
                        "wav",
                }
            ]

        elif audio_format == "opus":

            options["postprocessors"] = [
                {
                    "key":
                        "FFmpegExtractAudio",

                    "preferredcodec":
                        "opus",

                    "preferredquality":
                        str(
                            audio_quality
                        ),
                }
            ]

    else:

        if video_format == "mp4":

            options[
                "merge_output_format"
            ] = "mp4"

        elif video_format == "mkv":

            options[
                "merge_output_format"
            ] = "mkv"

        elif video_format == "webm":

            options[
                "merge_output_format"
            ] = "webm"

    return options