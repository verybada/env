import os
from pathlib import Path


def Settings(**kwargs):
    path = Path("/Users/g02167/workspace")
    my_sys_path = list()
    for folder in path.iterdir():
        parts = str(folder).split("/")
        package_name = parts[-1]
        if not package_name.startswith("mop"):
            continue

        my_sys_path.append(folder)

    return {"sys_path": my_sys_path}
