from pathlib import Path

# terminalPictures/
PROJECT_DIR = Path(__file__).resolve().parent.parent

# terminalPictures/AnimePictures
IMAGE_DIR = PROJECT_DIR / "AnimePictures"

# terminalPictures/data/dataPictures.txt
DATA_FILE = PROJECT_DIR / "data" / "dataPictures.txt"

IMAGE_EXTENSIONS = {".png", ".jpg", ".jpeg", ".webp"}


class WorkData:

    @staticmethod
    def update():
        images = sorted(
            str(file.resolve())
            for file in IMAGE_DIR.rglob("*")
            if file.is_file() and file.suffix.lower() in IMAGE_EXTENSIONS
        )

        DATA_FILE.write_text("\n".join(images), encoding="utf-8")
        print(len(images))

if __name__ == "__main__":
    WorkData.update()