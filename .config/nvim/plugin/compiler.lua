local cfgs = {
    c      = { build = "gcc % -o %<",           run = "./%<" },
    cpp    = { build = "g++ % -o %<",           run = "./%<" },
    dot    = { build = "dot -Tpdf % -o %<.pdf", run = nil },
    go     = { build = "go build %",            run = "go run %" },
    hs     = { build = nil,                     run = "runhaskell %" },
    lua    = { build = nil,                     run = "lua %" },
    python = { build = nil,                     run = "python3 %" },
    rust   = { build = "cargo build",           run = "cargo run" },
    sh     = { build = nil,                     run = "sh %" },
    tex    = { build = nil,                     run = "latexmk -interaction=nonstopmode -pdf -quiet -shell-escape %" },
    ts     = { build = "tsc %",                 run = "node %<.js" },
}

vim.api.nvim_create_user_command("Make", function(opts)
    local ft = vim.bo.filetype
    local cfg = cfgs[ft]

    if not cfg then
        vim.notify((":Make undefined for %s"):format(ft), vim.log.levels.ERROR)
        return
    end

    local action = (opts.args and opts.args ~= "")
        or (cfg.build and "build")
        or (cfg.run and "run")
        or "all"

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
        return { "all", "build", "run" }
    end,
})
