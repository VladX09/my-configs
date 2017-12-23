import argparse
import pathlib
import os
import shutil
import sys

configs = {
    ".Xresources": "~/",
    "scripts/": "~/.local/",
    "lightdm/": "/etc/",
    "settings.ini": "~/.config/gtk-3.0/",
    ".gtkrc-2.0": "~/",
    "bspwm/": "~/.config/",
    "sxhkd/": "~/.config/",
    "awesome": "/usr/share/fonts/opentype/",
    "compton.conf" : "~/.config"
}

cur_dir = pathlib.Path(os.path.dirname(__file__))


def configure_parser():
    parser = argparse.ArgumentParser(
        description="Collect or deploy custom configs")
    parser.add_argument("--deploy", action="store_true")
    parser.add_argument("--list", action="store_true")
    parser.add_argument("files", nargs="*")
    return parser


def list_paths():
    for file, src_fld in configs.items():
        src = pathlib.Path(src_fld).expanduser() / file
        dst = cur_dir / file
        print("{} <-> {}".format(src, dst))


def collect_files(files):
    for file in files:
        src = pathlib.Path(configs[file]).expanduser() / file
        dst = cur_dir / file
        print("{} -> {}".format(src, dst))
        if src.is_dir():
            shutil.copytree(src, dst)
        else:
            shutil.copy(src, dst)


def deploy_files(files):
    pass


if __name__ == "__main__":
    parser = configure_parser()
    args = parser.parse_args()
    if args.list:
        list_paths()
        sys.exit()

    if (len(args.files) == 0):
        files = configs.keys()
    else:
        files = args.files

    if args.deploy:
        deploy_files(files)
    else:
        collect_files(files)
