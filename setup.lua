#!/usr/bin/env lua
--
-- Author:   David Oniani
--
--           _                _
--  ___  ___| |_ _   _ _ __  | |_   _  __ _
-- / __|/ _ \ __| | | | '_ \ | | | | |/ _` |
-- \__ \  __/ |_| |_| | |_) || | |_| | (_| |
-- |___/\___|\__|\__,_| .__(_)_|\__,_|\__,_|
--                    |_|
--

-- Home environment variable
HOME = os.getenv("HOME")

-- Configuration folder
CFG = string.format("%s/.config", HOME)
if os.getenv("XDG_CONFIG_HOME") ~= nil then
    CFG = os.getenv("XDG_CONFIG_HOME")
end

-- Data folder
DATA = string.format("%s/.local/share", HOME)
if os.getenv("XDG_DATA_HOME") ~= nil then
    DATA = os.getenv("XDG_DATA_HOME")
end

-- Configuration files and folders
CFGS = { ".config", ".local", ".ghc", ".zshenv" }

-- Git repositories
ZSH_AUTOSUGGEST_REPOSITORY = "https://github.com/zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_DIR = string.format("%s/zsh/plugin/zsh-autosuggestions", DATA)

ZSH_SYNTAX_REPOSITORY = "https://github.com/zsh-users/zsh-syntax-highlighting"
ZSH_SYNTAX_DIR = string.format("%s/zsh/plugin/zsh-syntax-highlighting", DATA)

--- Clone a Git repository
-- Quietly clone a Git repository
-- @param link a link to the repository
-- @param path a path to where the repository should be cloned
-- @return nil
function Clone(link, path)
    os.execute(string.format("git clone --quiet %s %s", link, path))
end

--- Copy a file or directory
-- Force copies a file or directory using UNIX's built-in `cp` utility
-- @param src a source to the file to be copied
-- @param dst a destination to where the source should be copied
-- @return nil
function Copy(src, dst)
    os.execute(string.format("cp -Rf %s %s", src, dst))
end

--- Remove a file or directory
-- Force removes a file or directory using UNIX's built-in `rm` utility
-- @param path a path of the file
-- @return nil
function Remove(path)
    os.execute(string.format("rm -rf %s", path))
end

-- Copy configs
for _, cfg in ipairs(CFGS) do
    Copy(cfg, HOME)
end

-- Install Z shell plugins
Remove(ZSH_AUTOSUGGEST_DIR)
Remove(ZSH_SYNTAX_DIR)

Clone(ZSH_AUTOSUGGEST_REPOSITORY, ZSH_AUTOSUGGEST_DIR)
Clone(ZSH_SYNTAX_REPOSITORY, ZSH_SYNTAX_DIR)
