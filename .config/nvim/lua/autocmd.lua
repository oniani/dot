-- Neovim configuration file
-- by David Oniani <onianidavid@gmail.com>
-- MIT License

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP configuration on attach",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(ev)
        local lsp_keymap_set = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        lsp_keymap_set("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        lsp_keymap_set("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        lsp_keymap_set("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        lsp_keymap_set("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        lsp_keymap_set("dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")
        lsp_keymap_set("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
        lsp_keymap_set("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")

        lsp_keymap_set("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        lsp_keymap_set("<Leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
        lsp_keymap_set("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        lsp_keymap_set("<Leader>ss", vim.lsp.buf.signature_help, "[S]how [S]ignature")
        lsp_keymap_set("<Leader>td", vim.lsp.buf.type_definition, "[T]ype [D]efinition")
        lsp_keymap_set("<Leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")

        lsp_keymap_set("K", vim.lsp.buf.hover, "Hover Documentation")

        vim.api.nvim_create_user_command("F", function() vim.lsp.buf.format() end,
            { desc = "LSP: [F]ormat" })

        local border_opt = { border = "single" }
        vim.diagnostic.config { float = border_opt, virtual_text = false }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opt)
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opt)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local hi_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
                group = hi_augroup,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
                group = hi_augroup,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                callback = function(ev2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = ev2.buf }
                end,
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            })
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Equalize splits when resized",
    group = vim.api.nvim_create_augroup("window-resize", { clear = true }),
    command = "wincmd =",
    pattern = "*",
})
