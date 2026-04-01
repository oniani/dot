-- Author: David Oniani <onianidavid@gmail.com>
-- Description: Neovim configuration file
-- License: MIT

-- Install nnn if not already installed
local function reinstall_nnn()
    local homedir = os.getenv "HOME"
    local path = vim.fs.joinpath(homedir, ".local", "bin", "nnn")

    -- Always reinstall (remove existing first if present)
    if vim.uv.fs_stat(path) then
        vim.notify("Removing existing nnn ...", vim.log.levels.INFO)
        os.remove(path)
    end

    -- Ensure ~/.local/bin exists
    vim.fn.mkdir(homedir .. "/.local/bin", "p")

    -- Install nnn
    vim.notify("Installing nnn ...", vim.log.levels.INFO)
    local cmd = table.concat({
        "git clone --depth 1 https://github.com/jarun/nnn",
        "make -C nnn O_NERD=1 O_QSORT=1",
        "mv nnn/nnn ~/.local/bin/",
        "rm -rf nnn",
    }, " && ")

    local result = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to install nnn:\n" .. result, vim.log.levels.ERROR)
        return
    end

    vim.notify("nnn was successfully installed", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("NNNReinstall", reinstall_nnn, {})

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
