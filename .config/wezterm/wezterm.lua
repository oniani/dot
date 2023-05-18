local modules = {
    "colors",
    "fonts",
    "keys",
    "ui",
}

local config = {}
for _, module in pairs(modules) do
    require(module).apply_to_config(config)
end

return config
