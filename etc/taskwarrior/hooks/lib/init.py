from os import path

_activated = False


def activate():
    dir_path = path.dirname(path.realpath(__file__))
    activate_this = path.realpath(
        path.join(dir_path, "..", ".venv", "bin", "activate_this.py")
    )

    exec(open(activate_this).read(), {"__file__": activate_this})
    _activated


if not _activated:
    activate()
