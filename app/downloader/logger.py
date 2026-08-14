class YTDLPLogger:

    def __init__(self, worker):

        self.worker = worker

    def debug(self, message):

        if message:

            self.worker.log.emit(
                f"[DEBUG] {message}"
            )

    def info(self, message):

        if message:

            self.worker.log.emit(
                f"[INFO] {message}"
            )

    def warning(self, message):

        if message:

            self.worker.log.emit(
                f"[WARNING] {message}"
            )

    def error(self, message):

        if message:

            self.worker.log.emit(
                f"[ERROR] {message}"
            )