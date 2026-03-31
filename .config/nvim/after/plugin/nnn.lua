-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

-- Install nnn if not already installed
local homedir = os.getenv "HOME"
local path = vim.fs.joinpath(homedir, ".local", "bin", "nnn")
local stat = vim.uv.fs_stat(path)

if not (stat and stat.type == "file" and vim.fn.executable(path) == 1) then
    vim.notify("Installing nnn ...", vim.log.levels.INFO)

    -- Ensure ~/.local/bin exists
    vim.fn.mkdir(homedir .. "/.local/bin", "p")

    -- Install nnn
    vim.fn.system(table.concat({
        "git clone --depth 1 https://github.com/jarun/nnn",
        "make -C nnn O_NERD=1 O_QSORT=1",
        "mv nnn/nnn ~/.local/bin/",
        "rm -rf nnn",
    }, " && "))

    vim.notify("nnn was successfully installed", vim.log.levels.INFO)
end

-- nnn.nvim setup
require("nnn").setup {
    explorer = {
        width = 32,
    },
}

vim.keymap.set({ "n", "t" }, "<C-n>", function()
    vim.cmd "NnnExplorer"
    -- We defer with 100ms delay to ensure nnn vsplit has time to open
    vim.defer_fn(function()
        vim.cmd.wincmd { args = { "p" } }
    end, 100)
end, { desc = "Toggle nnn in a vertical split" })

vim.keymap.set(
    { "n", "t" },
    "<C-b>",
    "<Cmd>NnnPicker<CR>",
    { desc = "Toggle nnn in a floating window" }
)
