local module = {}

function module.apply_to_config(config)
    config.cursor_blink_rate = 0
    config.use_fancy_tab_bar = false
    config.window_padding = {
        bottom = 0,
        left = 0,
        right = 0,
        top = 0,
    }
end

return module
