import argparse
import pathlib
import os
import shutil
import sys

configs = {
    ".Xresources": "~/.Xresources",
    "scripts/": "~/.local/scripts/",
    "lightdm/": "/etc/lightdm",
    "settings.ini": "~/.config/gtk-3.0/settings.ini",
    ".gtkrc-2.0": "~/.gtkrc-2.0",
    "bspwm/": "~/.config/bspwm/",
    "sxhkd/": "~/.config/sxhkd/",
    "polybar/": "~/.config/polybar/",
    "awesome": "/usr/share/fonts/opentype/awesome",
    "compton.conf": "~/.config/compton.conf"
}


cur_dir = pathlib.Path(os.path.dirname(__file__))


def configure_parser():
    parser = argparse.ArgumentParser(
        description="Collect or deploy custom configs")
    parser.add_argument("--deploy", action="store_true")
    parser.add_argument("--list", action="store_true")
    parser.add_argument("files", nargs="*")
    return parser


def prepare_config_paths():
    sources = []
    destionations = []
    for file, src_fld in configs.items():
        sources.append(pathlib.Path(src_fld).expanduser())
        destionations.append(cur_dir / file)
    maxlen = max(len(str(path)) for path in sources)
    result = []
    for src, dst in zip(sources, destionations):
        result.append(f"{src!s:<{maxlen}} <-> {dst!s:<{maxlen}}")
    return result


def list_paths():
    for s in prepare_config_paths():
        print(s)


def collect_files(files):
    for file in files:
        src = pathlib.Path(configs[file]).expanduser()
        dst = cur_dir / file
        print(f"{src!s} -> {dst!s}")
        if src.is_dir():
            shutil.copytree(src, dst)
        else:
            shutil.copy(src, dst)


def deploy_files(files):
    pass


def select_files():
    for i, line in enumerate(prepare_config_paths()):
        print(f"[{i}] : {line}")
    print("Select files:")


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
