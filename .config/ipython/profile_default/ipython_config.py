# IPython configuration file
# by David Oniani <onianidavid@gmail.com>
# MIT License

from IPython.terminal.prompts import ClassicPrompts

config = get_config()

config.InteractiveShell.colors = "Linux"
config.TerminalIPythonApp.display_banner = False
config.TerminalInteractiveShell.confirm_exit = False
config.TerminalInteractiveShell.editing_mode = "vi"
config.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
config.TerminalInteractiveShell.highlight_matching_brackets = True
config.TerminalInteractiveShell.prompts_class = ClassicPrompts
config.TerminalInteractiveShell.separate_in = ""
