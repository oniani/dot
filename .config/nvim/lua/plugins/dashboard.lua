-- Access global editor variables
local g = vim.g

-- Custom header
g.dashboard_custom_header = {
    "███████╗██████╗  █████╗  ██████╗███████╗███████╗██╗  ██╗██╗██████╗ ",
    "██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝██║  ██║██║██╔══██╗",
    "███████╗██████╔╝███████║██║     █████╗  ███████╗███████║██║██████╔╝",
    "╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝  ╚════██║██╔══██║██║██╔═══╝ ",
    "███████║██║     ██║  ██║╚██████╗███████╗███████║██║  ██║██║██║     ",
    "╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝     "
}

-- Use fzf as the default program
g.dashboard_default_executive = "fzf"

g.dashboard_custom_section = {
    a = {description = {"  New File       "}, command = "enew"},
    b = {description = {"  Find File      "}, command = "Files"},
    c = {description = {"  Find Text      "}, command = "Rg"},
    d = {description = {"  Recent Files   "}, command = "History"}
}

g.dashboard_custom_footer = {
    "         GitHub:   @oniani", "         LinkedIn: @davidoniani",
    "         Website:  www.davidoniani.com", "",
    "        curl -Ls www.davidoniani.com/card | sh"
}
