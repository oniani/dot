local module = {}

function module.apply_to_config(config)
    config.colors = {
        background = "#000000",
        foreground = "#dcd7ba",

        cursor_bg = "#52ad70",
        cursor_border = "#52ad70",
        cursor_fg = "black",

        selection_bg = "#dfbf8e",
        selection_fg = "#1d2021",

        scrollbar_thumb = "#222222",

        split = "#444444",

        ansi = {
            "#665c54",
            "#ea6962",
            "#a9b665",
            "#e78a4e",
            "#8ba8f0",
            "#d3869b",
            "#89b482",
            "#dfbf8e",
        },
        brights = {
            "#928374",
            "#ea6962",
            "#a9b665",
            "#e3a84e",
            "#8ba8f0",
            "#d3869b",
            "#89b482",
            "#dfbf8e",
        },

        tab_bar = {
            background = "#000000",
            new_tab = {
                bg_color = '#000000',
                fg_color = '#808080',
            }
        }
    }
end

return module
