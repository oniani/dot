#!/usr/bin/env python3
import argparse
import os


class VisualBar:
    blk: str = "\u2588"

    def fmt_print(self, out: int, name="", end="%") -> None:
        """Formats and prints the visual bar."""

        used = round(out / 10)
        string = f"{name} [{self.blk * used}{' ' * (10 - used)}] {out}{end}"
        print(string)

    def volume(self) -> None:
        """Displays the volume level."""

        volume = int(
            os.popen("amixer sget Master | awk -F\"[][]\" '/dB/ { print $2 }'").read()[:-2]
        )
        self.fmt_print(out=volume, name="volume")

    def battery(self) -> None:
        """Displays the battery status."""

        battery = int(os.popen("cat /sys/class/power_supply/BAT0/capacity").read())
        self.fmt_print(out=battery, name="battery")

    def disk(self) -> None:
        """Displays the disk usage."""

        disk = int(os.popen("df -h --output=pcent / | tail -n 1").read()[:-2])
        self.fmt_print(out=disk, name="disk usage")


def main() -> None:
    """Parses the command line arguments and displays the visual bar."""

    parser = argparse.ArgumentParser("VisualBar")
    parser.add_argument("--type", type=str, help="visual bar type", required=True)
    args = parser.parse_args()

    vb_type = args.type.lower()
    vb = VisualBar()
    if vb_type == "battery":
        vb.battery()
    elif vb_type == "disk":
        vb.disk()
    elif vb_type == "volume":
        vb.volume()


if __name__ == "__main__":
    main()
