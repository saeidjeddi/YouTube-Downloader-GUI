import sys
from pathlib import Path


def get_ffmpeg_path():

    if getattr(sys, "frozen", False):

        base_dir = Path(sys.executable).resolve().parent

        ffmpeg_dir = base_dir / "bin"

        if not (ffmpeg_dir / "ffmpeg").exists():
            raise FileNotFoundError(f"FFmpeg not found: " f"{ffmpeg_dir / 'ffmpeg'}")

        if not (ffmpeg_dir / "ffprobe").exists():
            raise FileNotFoundError(f"FFprobe not found: " f"{ffmpeg_dir / 'ffprobe'}")

        return str(ffmpeg_dir)

    return "ffmpeg"
