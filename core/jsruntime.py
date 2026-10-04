import shutil
import sys
from pathlib import Path


def get_js_runtimes():
    """
    Return the `js_runtimes` dict for yt-dlp.

    YouTube needs a JavaScript runtime to solve its signature / n challenges.
    Search order:
      1. deno bundled next to the frozen app (<app dir>/bin/deno)
      2. deno found on PATH
      3. ~/.deno/bin/deno (default location of the official installer)

    Returns None when deno is not found, so yt-dlp falls back to its default.
    """

    candidates = []

    if getattr(sys, "frozen", False):
        base_dir = Path(sys.executable).resolve().parent
        candidates.append(base_dir / "bin" / "deno")

    on_path = shutil.which("deno")

    if on_path:
        candidates.append(Path(on_path))

    candidates.append(Path.home() / ".deno" / "bin" / "deno")

    for path in candidates:
        if path.is_file():
            return {"deno": {"path": str(path)}}

    return None
