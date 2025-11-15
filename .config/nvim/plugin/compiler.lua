local cfgs = {
    c = { build = "gcc % -o %<", run = "./%<", test = nil },
    cpp = { build = "g++ % -o %<", run = "./%<", test = nil },
    dot = { build = "dot -Tpdf % -o %<.pdf", run = nil, test = nil },
    go = { build = "go build %", run = "go run %", test = nil },
    hs = { build = nil, run = "runhaskell %", test = nil },
    lua = { build = nil, run = "lua %", test = nil },
    python = { build = nil, run = "python3 %", test = nil },
    rust = { build = "cargo build", run = "cargo run", test = "cargo test" },
    sh = { build = nil, run = "sh %", test = nil },
    tex = {
        build = nil,
        run = "latexmk -interaction=nonstopmode -pdf -quiet -shell-escape %",
        test = nil,
    },
    ts = { build = "tsc %", run = "node %<.js", test = nil },
}

vim.api.nvim_create_user_command("Make", function(opts)
    local ft = vim.bo.filetype
    local cfg = cfgs[ft]

    if not cfg then
        vim.notify((":Make undefined for %s"):format(ft), vim.log.levels.ERROR)
        return
    end

    local action = opts.args
    local cmd = cfg[action]
    if not cmd then
        if action == "all" then
            cmd = table.concat({ cfg.build, cfg.run }, " && ")
        else
            vim.notify((":Make %s undefined for %s"):format(action, ft), vim.log.levels.ERROR)
            return
        end
    end

    vim.bo.makeprg = cmd
    vim.cmd "make"
end, {
    nargs = "?",
    complete = function()
        return { "all", "build", "run", "test" }
    end,
})
