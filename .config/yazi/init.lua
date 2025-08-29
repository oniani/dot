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
    install "yazi-rs/plugins:no-status"
    install "yazi-rs/plugins:smart-enter"
end
require("full-border"):setup { type = ui.Border.PLAIN }
require("git"):setup()
require("no-status"):setup()

-- Add an empty space after icons
function Entity:prefix()
    return " "
end

-- Remove the header
local old_layout = Tab.layout
Tab.layout = function(self, ...)
    self._area = ui.Rect {
        x = self._area.x,
        y = self._area.y - 1,
        w = self._area.w,
        h = self._area.h + 1,
    }
    return old_layout(self, ...)
end
