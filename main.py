import json
import sys
from pathlib import Path
import subprocess

from skript import GetRandom, SetRandomMod, set_config

PROJECT_DIR = Path(__file__).resolve().parent
STATUS_FILE = PROJECT_DIR / "configs" / "StatusRandomMod.jsonc"
FASTFETCH_CONFIG = PROJECT_DIR / "configs" / "fastfetchConfig.jsonc"


"""
STATUS_FILE="/home/Rezuk/dev/terminalPictures/configs/StatusRandomMod.jsonc"

STATUS=$(jq -r '.status' "$STATUS_FILE")

if [[ "$STATUS" == "All" || "$STATUS" == "usermod" ]]; then
    python3 /home/Rezuk/dev/terminalPictures/main.py randomGen
fi

if [[ -z "$DASHBOARD_MODE" ]]; then
    fastfetch -c /home/Rezuk/dev/terminalPictures/configs/fastfetchConfig.jsonc
fi
"""
class PrinInTerminal():

    def start():
        with open(STATUS_FILE, "r", encoding="utf-8") as f:
            config = json.load(f)

        status = config.get("status")

        if status == "usermod":
            RandomPictures.Random_usermod()
            pass

        subprocess.run(
            [
                "fastfetch",
                "-c",
                str(FASTFETCH_CONFIG ),
            ],
            check=True,
        )


class RandomPictures:

    def Random_usermod():
        picture = GetRandom.get_in_usermod()
        set_config(picture) 


class SetMods():

    def all_mod():
        SetRandomMod.set_all_mod()


    def usermod(path):
        SetRandomMod.set_path_usermod(path)


    def static(picture):
        SetRandomMod.off_mod()
        set_config(picture)
        print(picture)


if __name__ == "__main__":
    
    if len(sys.argv) <= 1:
        PrinInTerminal.start()
    else:
        command = sys.argv[1]
        if command == "randomGen":
            with open(STATUS_FILE, "r", encoding="utf-8") as file:
                config = json.load(file)
            status = config["status"]
            
            if status == "All":
                RandomPictures.Random_all_mod()

            if status == "usermod":
                RandomPictures.Random_usermod()

        if command == "setPicture":
            picture = (sys.argv[2])
            SetMods.static(picture)

        if command == "setAllMod":
            SetMods.all_mod()
            
        if command == "offRandomMod":
            SetMods.off_mod()

        if command == "setUserMod":
            Input_mod = (sys.argv[2])
            SetMods.usermod(Input_mod)

#python3 /home/Rezuk /dev/terminalPictures/main.py setUserModп
#~/.config/hypr/scripts/WaifuSelect.sh   
