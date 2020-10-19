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

c = get_config()

c.InteractiveShell.colors = "NoColor"
c.InteractiveShell.color_info = True
c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.separate_in = ""
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.prompts_class = ClassicPrompts
c.TerminalInteractiveShell.highlight_matching_brackets = True
