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
