from pathlib import Path

import yt_dlp

from PySide6.QtCore import QThread, Signal

from app.downloader.options import build_options


class DownloadWorker(QThread):

    progress = Signal(dict)

    log = Signal(str)

    finished = Signal(bool, str)

    def __init__(
        self,
        url,
        output_dir,
        mode,
        video_quality,
        video_format,
        audio_quality,
        audio_format,
    ):

        super().__init__()

        self.url = url

        self.output_dir = output_dir

        self.mode = mode

        self.video_quality = video_quality
        self.video_format = video_format

        self.audio_quality = audio_quality
        self.audio_format = audio_format

        self.stop_requested = False

    # --------------------------------------------------------
    # Stop
    # --------------------------------------------------------

    def stop(self):

        self.stop_requested = True

    # --------------------------------------------------------
    # Run
    # --------------------------------------------------------

    def run(self):

        try:

            output_dir = Path(
                self.output_dir
            ).expanduser()

            output_dir.mkdir(
                parents=True,
                exist_ok=True,
            )

            # =================================================
            # Output Template
            # =================================================

            output_template = (
                str(output_dir)
                + "/%(playlist_title|Video)s/"
                "%(playlist_index|1)s - %(title)s.%(ext)s"
            )

            # =================================================
            # Format
            # =================================================

            if self.mode == "audio":

                format_id = "bestaudio/best"

            else:

                # ------------------------------------------------
                # Video Quality
                # ------------------------------------------------

                if self.video_quality == "best":

                    video_format = "bestvideo"

                else:

                    video_format = (
                        f"bestvideo[height<={self.video_quality}]"
                    )

                # ------------------------------------------------
                # MP4
                # ------------------------------------------------

                if self.video_format == "mp4":

                    format_id = (
                        video_format
                        + "[ext=mp4]+"
                        "bestaudio[ext=m4a]/"
                        + video_format
                        + "+bestaudio/best"
                    )

                # ------------------------------------------------
                # WEBM
                # ------------------------------------------------

                elif self.video_format == "webm":

                    format_id = (
                        video_format
                        + "[ext=webm]+"
                        "bestaudio[ext=webm]/"
                        + video_format
                        + "+bestaudio/best"
                    )

                # ------------------------------------------------
                # MKV
                # ------------------------------------------------

                else:

                    format_id = (
                        video_format
                        + "+bestaudio/best"
                    )

            # =================================================
            # yt-dlp Options
            # =================================================

            options = build_options(

                worker=self,

                output_dir=output_dir,

                mode=self.mode,

                video_quality=self.video_quality,

                video_format=self.video_format,

                audio_quality=self.audio_quality,

                audio_format=self.audio_format,

                format_id=format_id,

                output_template=output_template,
            )

            # =================================================
            # Start Download
            # =================================================

            self.log.emit(
                "Starting yt-dlp..."
            )

            self.log.emit(
                f"Mode: {self.mode}"
            )

            self.log.emit(
                f"Format: {format_id}"
            )

            with yt_dlp.YoutubeDL(
                options
            ) as ydl:

                ydl.download(
                    [
                        self.url
                    ]
                )

            # =================================================
            # Finished
            # =================================================

            if self.stop_requested:

                self.finished.emit(
                    False,
                    "Download stopped.",
                )

                return

            self.finished.emit(
                True,
                "Download completed successfully.",
            )

        except Exception as e:

            self.finished.emit(
                False,
                str(e),
            )

    # ========================================================
    # Progress Hook
    # ========================================================

    def progress_hook(
        self,
        data,
    ):

        if self.stop_requested:

            raise yt_dlp.utils.DownloadError(
                "Download cancelled by user."
            )

        status = data.get(
            "status"
        )

        # ====================================================
        # Downloading
        # ====================================================

        if status == "downloading":

            downloaded = data.get(
                "downloaded_bytes",
                0,
            )

            total = (
                data.get(
                    "total_bytes"
                )
                or data.get(
                    "total_bytes_estimate"
                )
                or 0
            )

            percentage = 0

            if total:

                percentage = int(
                    downloaded
                    / total
                    * 100
                )

            self.progress.emit(
                {
                    "status":
                        "downloading",

                    "percentage":
                        percentage,

                    "downloaded":
                        downloaded,

                    "total":
                        total,

                    "speed":
                        data.get(
                            "speed"
                        ),

                    "eta":
                        data.get(
                            "eta"
                        ),

                    "filename":
                        data.get(
                            "filename",
                            "",
                        ),
                }
            )

        # ====================================================
        # Finished
        # ====================================================

        elif status == "finished":

            self.progress.emit(
                {
                    "status":
                        "finished",

                    "percentage":
                        100,

                    "filename":
                        data.get(
                            "filename",
                            "",
                        ),
                }
            )