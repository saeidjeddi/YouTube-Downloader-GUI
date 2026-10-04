from pathlib import Path

from PySide6.QtWidgets import (
    QFileDialog,
    QGridLayout,
    QGroupBox,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QMainWindow,
    QMessageBox,
    QPlainTextEdit,
    QProgressBar,
    QPushButton,
    QComboBox,
    QVBoxLayout,
    QWidget,
)

from app.downloader.worker import DownloadWorker

ICON_PATH = Path(__file__).resolve().parent.parent / "assets" / "icon" / "icon.png"



class MainWindow(QMainWindow):

    def __init__(self):

        super().__init__()

        self.worker = None

        self.setWindowTitle("YouTube Downloader")

        self.resize(
            850,
            650,
        )

        self.setup_ui()

        self.update_download_type()

    # ========================================================
    # UI
    # ========================================================

    def setup_ui(self):

        central = QWidget()

        self.setCentralWidget(central)

        main_layout = QVBoxLayout(central)

        # ====================================================
        # URL
        # ====================================================

        url_group = QGroupBox("YouTube URL")

        url_layout = QVBoxLayout(url_group)

        self.url_input = QLineEdit()

        self.url_input.setPlaceholderText("Paste YouTube video or playlist URL...")

        url_layout.addWidget(self.url_input)

        main_layout.addWidget(url_group)

        # ====================================================
        # Settings
        # ====================================================

        settings_group = QGroupBox("Download Settings")

        settings_layout = QGridLayout(settings_group)

        # ====================================================
        # Output Directory
        # ====================================================

        output_label = QLabel("Output folder:")

        self.output_input = QLineEdit(str(Path.home() / "Downloads"))

        browse_button = QPushButton("Browse")

        browse_button.clicked.connect(self.select_output_folder)

        settings_layout.addWidget(
            output_label,
            0,
            0,
        )

        settings_layout.addWidget(
            self.output_input,
            0,
            1,
        )

        settings_layout.addWidget(
            browse_button,
            0,
            2,
        )

        # ====================================================
        # Download Type
        # ====================================================

        type_label = QLabel("Type:")

        self.type_combo = QComboBox()

        self.type_combo.addItem(
            "Video",
            "video",
        )

        self.type_combo.addItem(
            "Audio Only",
            "audio",
        )

        self.type_combo.currentIndexChanged.connect(self.update_download_type)

        settings_layout.addWidget(
            type_label,
            1,
            0,
        )

        settings_layout.addWidget(
            self.type_combo,
            1,
            1,
            1,
            2,
        )

        # ====================================================
        # Video Quality
        # ====================================================

        self.video_quality_label = QLabel("Video quality:")

        self.video_quality_combo = QComboBox()

        self.video_quality_combo.addItem(
            "Best Available",
            "best",
        )

        self.video_quality_combo.addItem(
            "2160p (4K)",
            "2160",
        )

        self.video_quality_combo.addItem(
            "1440p (2K)",
            "1440",
        )

        self.video_quality_combo.addItem(
            "1080p (Full HD)",
            "1080",
        )

        self.video_quality_combo.addItem(
            "720p (HD)",
            "720",
        )

        self.video_quality_combo.addItem(
            "480p",
            "480",
        )

        self.video_quality_combo.addItem(
            "360p",
            "360",
        )

        settings_layout.addWidget(
            self.video_quality_label,
            2,
            0,
        )

        settings_layout.addWidget(
            self.video_quality_combo,
            2,
            1,
            1,
            2,
        )

        # ====================================================
        # Video Format
        # ====================================================

        self.video_format_label = QLabel("Video format:")

        self.video_format_combo = QComboBox()

        self.video_format_combo.addItem(
            "MP4",
            "mp4",
        )

        self.video_format_combo.addItem(
            "MKV",
            "mkv",
        )

        self.video_format_combo.addItem(
            "WEBM",
            "webm",
        )

        settings_layout.addWidget(
            self.video_format_label,
            3,
            0,
        )

        settings_layout.addWidget(
            self.video_format_combo,
            3,
            1,
            1,
            2,
        )

        # ====================================================
        # Audio Format
        # ====================================================

        self.audio_format_label = QLabel("Audio format:")

        self.audio_format_combo = QComboBox()

        self.audio_format_combo.addItem(
            "MP3",
            "mp3",
        )

        self.audio_format_combo.addItem(
            "M4A",
            "m4a",
        )

        self.audio_format_combo.addItem(
            "WAV",
            "wav",
        )

        self.audio_format_combo.addItem(
            "OPUS",
            "opus",
        )

        settings_layout.addWidget(
            self.audio_format_label,
            4,
            0,
        )

        settings_layout.addWidget(
            self.audio_format_combo,
            4,
            1,
            1,
            2,
        )

        # ====================================================
        # Audio Quality
        # ====================================================

        self.audio_quality_label = QLabel("Audio quality:")

        self.audio_quality_combo = QComboBox()

        self.audio_quality_combo.addItem(
            "128 kbps",
            "128",
        )

        self.audio_quality_combo.addItem(
            "192 kbps",
            "192",
        )

        self.audio_quality_combo.addItem(
            "256 kbps",
            "256",
        )

        self.audio_quality_combo.addItem(
            "320 kbps",
            "320",
        )

        self.audio_quality_combo.setCurrentIndex(1)

        settings_layout.addWidget(
            self.audio_quality_label,
            5,
            0,
        )

        settings_layout.addWidget(
            self.audio_quality_combo,
            5,
            1,
            1,
            2,
        )

        main_layout.addWidget(settings_group)

        # ====================================================
        # Progress
        # ====================================================

        progress_group = QGroupBox("Download Progress")

        progress_layout = QVBoxLayout(progress_group)

        self.status_label = QLabel("Ready")

        self.progress_bar = QProgressBar()

        self.progress_bar.setValue(0)

        self.speed_label = QLabel("Speed: -")

        self.eta_label = QLabel("ETA: -")

        self.file_label = QLabel("File: -")

        progress_layout.addWidget(self.status_label)

        progress_layout.addWidget(self.progress_bar)

        progress_layout.addWidget(self.speed_label)

        progress_layout.addWidget(self.eta_label)

        progress_layout.addWidget(self.file_label)

        main_layout.addWidget(progress_group)

        # ====================================================
        # Buttons
        # ====================================================

        button_layout = QHBoxLayout()

        self.download_button = QPushButton("▶ Start Download")

        self.stop_button = QPushButton("■ Stop")

        self.stop_button.setEnabled(False)

        self.download_button.clicked.connect(self.start_download)

        self.stop_button.clicked.connect(self.stop_download)

        button_layout.addWidget(self.download_button)

        button_layout.addWidget(self.stop_button)

        main_layout.addLayout(button_layout)

        # ====================================================
        # Log
        # ====================================================

        log_group = QGroupBox("Log")

        log_layout = QVBoxLayout(log_group)

        self.log_output = QPlainTextEdit()

        self.log_output.setReadOnly(True)

        log_layout.addWidget(self.log_output)

        main_layout.addWidget(log_group)

    # ========================================================
    # Update Download Type
    # ========================================================

    def update_download_type(self):

        is_video = self.type_combo.currentData() == "video"

        self.video_quality_label.setEnabled(is_video)

        self.video_quality_combo.setEnabled(is_video)

        self.video_format_label.setEnabled(is_video)

        self.video_format_combo.setEnabled(is_video)

        self.audio_format_label.setEnabled(not is_video)

        self.audio_format_combo.setEnabled(not is_video)

        self.audio_quality_label.setEnabled(not is_video)

        self.audio_quality_combo.setEnabled(not is_video)

    # ========================================================
    # Select Folder
    # ========================================================

    def select_output_folder(self):

        folder = QFileDialog.getExistingDirectory(
            self,
            "Select Output Folder",
            self.output_input.text(),
        )

        if folder:

            self.output_input.setText(folder)

    # ========================================================
    # Start
    # ========================================================

    def start_download(self):

        url = self.url_input.text().strip()

        if not url:

            QMessageBox.warning(
                self,
                "Invalid URL",
                "Please enter a YouTube URL.",
            )

            return

        output_dir = self.output_input.text().strip()

        if not output_dir:

            QMessageBox.warning(
                self,
                "Invalid Folder",
                "Please select an output folder.",
            )

            return

        mode = self.type_combo.currentData()

        video_quality = self.video_quality_combo.currentData()

        video_format = self.video_format_combo.currentData()

        audio_quality = self.audio_quality_combo.currentData()

        audio_format = self.audio_format_combo.currentData()

        self.log_output.clear()

        self.progress_bar.setValue(0)

        self.status_label.setText("Starting...")

        self.speed_label.setText("Speed: -")

        self.eta_label.setText("ETA: -")

        self.file_label.setText("File: -")

        self.download_button.setEnabled(False)

        self.stop_button.setEnabled(True)

        self.worker = DownloadWorker(
            url=url,
            output_dir=output_dir,
            mode=mode,
            video_quality=video_quality,
            video_format=video_format,
            audio_quality=audio_quality,
            audio_format=audio_format,
        )

        self.worker.progress.connect(self.update_progress)

        self.worker.log.connect(self.add_log)

        self.worker.finished.connect(self.download_finished)

        self.worker.start()

    # ========================================================
    # Stop
    # ========================================================

    def stop_download(self):

        if self.worker:

            self.worker.stop()

            self.status_label.setText("Stopping...")

            self.add_log("Stopping download...")

            self.stop_button.setEnabled(False)

    # ========================================================
    # Progress
    # ========================================================

    def update_progress(
        self,
        data,
    ):

        percentage = data.get(
            "percentage",
            0,
        )

        self.progress_bar.setValue(percentage)

        status = data.get("status")

        if status == "downloading":

            self.status_label.setText(f"Downloading... " f"{percentage}%")

            speed = data.get("speed")

            if speed:

                self.speed_label.setText("Speed: " + self.format_bytes(speed) + "/s")

            eta = data.get("eta")

            if eta is not None:

                self.eta_label.setText("ETA: " + self.format_eta(eta))

            filename = data.get(
                "filename",
                "",
            )

            if filename:

                self.file_label.setText("File: " + Path(filename).name)

        elif status == "finished":

            self.status_label.setText("Processing...")

    # ========================================================
    # Log
    # ========================================================

    def add_log(
        self,
        message,
    ):

        self.log_output.appendPlainText(message)

    # ========================================================
    # Finished
    # ========================================================

    def download_finished(
        self,
        success,
        message,
    ):

        self.download_button.setEnabled(True)

        self.stop_button.setEnabled(False)

        if success:

            self.progress_bar.setValue(100)

            self.status_label.setText("Completed ✓")

            self.add_log(message)

            QMessageBox.information(
                self,
                "Download Complete",
                message,
            )

        else:

            self.status_label.setText("Failed")

            self.add_log("ERROR: " + message)

        self.worker = None

    # ========================================================
    # Format Bytes
    # ========================================================

    @staticmethod
    def format_bytes(
        value,
    ):

        value = float(value)

        units = [
            "B",
            "KB",
            "MB",
            "GB",
            "TB",
        ]

        for unit in units:

            if value < 1024:

                return f"{value:.2f} {unit}"

            value /= 1024

        return f"{value:.2f} PB"

    # ========================================================
    # Format ETA
    # ========================================================

    @staticmethod
    def format_eta(
        seconds,
    ):

        if seconds is None:

            return "-"

        seconds = int(seconds)

        hours, remainder = divmod(
            seconds,
            3600,
        )

        minutes, seconds = divmod(
            remainder,
            60,
        )

        if hours:

            return f"{hours:02}:" f"{minutes:02}:" f"{seconds:02}"

        return f"{minutes:02}:" f"{seconds:02}"
