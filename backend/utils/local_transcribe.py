import whisper
import sys
import os
import warnings

warnings.filterwarnings("ignore")

def configure_ffmpeg(ffmpeg_path):
    if not ffmpeg_path:
        return

    normalized = os.path.abspath(ffmpeg_path)
    ffmpeg_dir = normalized if os.path.isdir(normalized) else os.path.dirname(normalized)
    os.environ["PATH"] = ffmpeg_dir + os.pathsep + os.environ.get("PATH", "")

def transcribe(audio_path):
    if not os.path.exists(audio_path):
        print("ERROR: File not found.")
        return

    model = whisper.load_model("base")  # change to 'small' or 'medium' if needed
    result = model.transcribe(audio_path)
    print(result["text"],flush=True)  # Output only transcript

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("ERROR: Audio path not provided.")
    else:
        ffmpeg_path = ""
        if len(sys.argv) >= 4 and sys.argv[2] == "--ffmpeg-path":
            ffmpeg_path = sys.argv[3]

        configure_ffmpeg(ffmpeg_path)
        transcribe(sys.argv[1])
