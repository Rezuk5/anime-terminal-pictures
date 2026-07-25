import json
from pathlib import Path
import random

PROJECT_DIR = Path(__file__).resolve().parent
CONF_FILE = PROJECT_DIR / "configs" / "fastfetchConfig.jsonc"
STATUS_FILE = PROJECT_DIR / "configs" / "StatusRandomMod.jsonc"
DATA_FILE = PROJECT_DIR / "data" / "dataPictures.txt"
IMAGE_DIR = PROJECT_DIR / "AnimePictures"

#
class GetRandom():
    """
    @staticmethod
    def get_in_all():


        with open(DATA_FILE, "r", encoding="utf-8") as file:
            pictures = [line.strip() for line in file if line.strip()]

        picture = random.choice(pictures)
        return picture
        """

    # work STATUS_FILE  and IMAGE_DIR
    @staticmethod
    def get_in_usermod():
        with open(STATUS_FILE, "r", encoding="utf-8") as file:
            status = json.load(file)

        #user_path = Path(status["usermod"]["path"])

        format_file = ".png", ".jpg", ".jpeg", ".webp"

        if (status["usermod"]["path"]) == "All":
            with open(DATA_FILE, "r", encoding="utf-8") as file:
                pictures = [line.strip() for line in file if line.strip()]

            pictures = [
                picture
                for picture in pictures
                if picture.lower().endswith(format_file)
            ]

        else:            
            pictures = [
                str(file)
                for file in Path(status["usermod"]["path"]).iterdir()
                if file.is_file() and file.suffix.lower() in format_file
            ]


        if status["usermod"]["name"] != "":
            pictures = [
                picture
                for picture in pictures
                if status["usermod"]["name"] in picture
            ]

        picture = random.choice(pictures)
        return picture


# STATUS_FILE work
class SetRandomMod:

    def _load():
        with open(STATUS_FILE, "r", encoding="utf-8") as file:
            return json.load(file)

    def _save(data):
        with open(STATUS_FILE, "w", encoding="utf-8") as file:
            json.dump(data, file, ensure_ascii=False, indent=4)

    def off_mod():
        data = SetRandomMod._load()
        data["status"] = False
        data["usermod"]["path"] = ""
        data["usermod"]["name"] = ""
        SetRandomMod._save(data)

    def set_all_mod():
        data = SetRandomMod._load()
        data["status"] = "usermod"
        data["usermod"]["path"] = "All"
        data["usermod"]["name"] = ""
        SetRandomMod._save(data)


    def set_path_usermod(path: str):
        data = SetRandomMod._load()
        data["status"] = "usermod"
        data["usermod"]["path"] = path
        data["usermod"]["name"] = ""
        SetRandomMod._save(data)


    def set_name_usermod(path: str, name: str):
        data = SetRandomMod._load()
        data["status"] = "usermod"
        data["usermod"]["path"] = path
        data["usermod"]["name"] = name
        SetRandomMod._save(data)     



#CONF_FILE work
def set_config(picture):
    new_logo = {
        "type": "auto",
        "source": picture,
        "height": 10,
        "padding": {
            "top": 1,
            "right": 4
        }
    }


    with open(CONF_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    data["logo"] = new_logo

    with open(CONF_FILE, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4, ensure_ascii=False)