return {
    "ibhagwan/fzf-lua",
    config = function()
        local fzf = require "fzf-lua"
        vim.keymap.set("n", "<Leader>d", fzf.diagnostics_document, { desc = "LSP: [D]iagnostics" })
        vim.keymap.set("n", "<Leader>f", fzf.files, { desc = "Find [F]iles" })
        vim.keymap.set("n", "<Leader>l", fzf.lines, { desc = "Open [L]ines" })
        vim.keymap.set("n", "<Leader>r", fzf.live_grep, { desc = "Search Terms via [R]g" })
        vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" }
    end,
}
