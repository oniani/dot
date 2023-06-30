local wezterm = require "wezterm"

local module = {}

function module.apply_to_config(config)
    config.adjust_window_size_when_changing_font_size = false
    config.font = wezterm.font "JetBrains Mono Nerd Font"
    config.font_size = 16.0
end

return module
