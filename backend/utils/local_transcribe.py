import whisper
import sys
import os
import warnings

warnings.filterwarnings("ignore")

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
        transcribe(sys.argv[1])