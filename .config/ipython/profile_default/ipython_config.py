#
# Author: David Oniani
#
#  _             _   _                                     __ _
# (_)_ __  _   _| |_| |__   ___  _ __      ___ ___  _ __  / _(_) __ _
# | | '_ \| | | | __| '_ \ / _ \| '_ \    / __/ _ \| '_ \| |_| |/ _` |
# | | |_) | |_| | |_| | | | (_) | | | |  | (_| (_) | | | |  _| | (_| |
# |_| .__/ \__, |\__|_| |_|\___/|_| |_|___\___\___/|_| |_|_| |_|\__, |
#   |_|    |___/                     |_____|                    |___/
#

from IPython.terminal.prompts import ClassicPrompts

config = get_config()

config.InteractiveShell.colors = "Linux"
config.InteractiveShell.color_info = True
config.TerminalIPythonApp.display_banner = False
config.TerminalInteractiveShell.confirm_exit = False
config.TerminalInteractiveShell.editing_mode = "vi"
config.TerminalInteractiveShell.highlight_matching_brackets = True
config.TerminalInteractiveShell.prompts_class = ClassicPrompts
config.TerminalInteractiveShell.separate_in = ""
