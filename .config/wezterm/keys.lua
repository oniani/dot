local wezterm = require "wezterm"

local module = {}

function module.apply_to_config(config)
    config.keys = {
        {
            key = "Enter",
            mods = "CTRL|SHIFT",
            action = wezterm.action.SpawnTab "CurrentPaneDomain",
        },
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action.MoveTabRelative(-1),
        },
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action.MoveTabRelative(1),
        },
    }
end

return module
