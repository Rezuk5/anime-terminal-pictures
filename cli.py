import argparse
import json
import subprocess
from pathlib import Path

from data.workData import WorkData
from skripts.functional import GetRandom, SetRandomMod, set_config


PROJECT_DIR = Path(__file__).resolve().parent
STATUS_FILE = PROJECT_DIR / "configs" / "StatusRandomMod.jsonc"
FASTFETCH_CONFIG = PROJECT_DIR / "configs" / "fastfetchConfig.jsonc"
MENU = PROJECT_DIR / "terminalGui" / "menu.sh"

class PrinInTerminal:

    def start():
        with open(STATUS_FILE, "r", encoding="utf-8") as f:
            config = json.load(f)

        if config.get("status") == "usermod":
            RandomPictures.Random_usermod()

        subprocess.run(
            [
                "fastfetch",
                "-c",
                str(FASTFETCH_CONFIG),
            ],
            check=True,
        )


class RandomPictures:

    def Random_usermod():
        picture = GetRandom.get_in_usermod()
        set_config(picture)


class SetMods:

    def all_mod():
        SetRandomMod.set_all_mod()

    def usermod(path):
        SetRandomMod.set_path_usermod(path)

    def usermodname(path, name):
        SetRandomMod.set_name_usermod(path, name)

    def static(picture):
        SetRandomMod.off_mod()
        set_config(picture)


def main():
    parser = argparse.ArgumentParser(
        prog="atp",
        description="Anime Terminal Pictures"
    )

    sub = parser.add_subparsers(dest="command")

    sub.add_parser("updateData")
    sub.add_parser("randomGen")
    sub.add_parser("setAllMod")

    picture = sub.add_parser("setPicture")
    picture.add_argument("picture")

    user = sub.add_parser("setUserMod")
    user.add_argument("path")
    user.add_argument("name", nargs="?")

    args = parser.parse_args()

    if args.command is None:
        PrinInTerminal.start()

    elif args.command == "randomGen":
        with open(STATUS_FILE, "r", encoding="utf-8") as f:
            config = json.load(f)

        if config["status"] == "All":
            RandomPictures.Random_all_mod()

        elif config["status"] == "usermod":
            RandomPictures.Random_usermod()

    elif args.command == "setPicture":
        SetMods.static(args.picture)

    elif args.command == "setAllMod":
        SetMods.all_mod()

    elif args.command == "setUserMod":
        if args.name:
            SetMods.usermodname(args.path, args.name)
        else:
            SetMods.usermod(args.path)

    elif args.command == "updateData":
        WorkData()
    elif args.command == "gui":
        subprocess.run([str(MENU)], check=True)


if __name__ == "__main__":
    main()