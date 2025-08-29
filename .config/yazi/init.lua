-- Install plugins if not already installed
local function file_exists(path)
    local f = io.open(path, "r")
    return f and f:close()
end

local function install(package)
    os.execute("ya pkg add " .. package)
end

if not file_exists(os.getenv "XDG_CONFIG_HOME" .. "/yazi/package.toml") then
    install "yazi-rs/plugins:full-border"
    install "yazi-rs/plugins:git"
    install "yazi-rs/plugins:smart-enter"
end
require("full-border"):setup { type = ui.Border.PLAIN }
require("git"):setup()

-- Add an empty space after icons
function Entity:prefix()
    return " "
end
