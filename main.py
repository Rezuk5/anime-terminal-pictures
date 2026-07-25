import json
import sys
from pathlib import Path
import subprocess

from data.workData import WorkData
from skript import GetRandom, SetRandomMod, set_config

PROJECT_DIR = Path(__file__).resolve().parent
STATUS_FILE = PROJECT_DIR / "configs" / "StatusRandomMod.jsonc"
FASTFETCH_CONFIG = PROJECT_DIR / "configs" / "fastfetchConfig.jsonc"


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

    def usermodname(path, name):
        SetRandomMod.set_name_usermod(path, name)

    def static(picture):
        SetRandomMod.off_mod()
        set_config(picture)


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

        if command == "setUserMod" and len(sys.argv) == 3:
            Input_mod = (sys.argv[2])
            SetMods.usermod(Input_mod)
        if command == "setUserMod" and len(sys.argv) == 4:
            Input_path = (sys.argv[2])
            Input_name = (sys.argv[3])
            SetMods.usermodname(Input_path, Input_name)
        
        if command == "updateData":
            WorkData()
            


#python3 /home/Rezuk /dev/terminalPictures/main.py setUserModп
#~/.config/hypr/scripts/WaifuSelect.sh   
