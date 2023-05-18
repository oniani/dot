local module = {}

function module.apply_to_config(config)
    config.cursor_blink_rate = 0
    config.use_fancy_tab_bar = false
end

return module
