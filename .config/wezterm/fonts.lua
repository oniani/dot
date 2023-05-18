local wezterm = require "wezterm"

local module = {}

function module.apply_to_config(config)
    config.font = wezterm.font "JetBrains Mono"
    config.font_size = 16.0
end

return module
