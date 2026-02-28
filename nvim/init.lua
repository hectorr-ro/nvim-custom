-- ============================================================================
--  Neovim IDE — Entry point
-- ============================================================================

-- Disable netrw (replaced by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key BEFORE lazy.nvim loads any plugin
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core modules
require("config.options")  -- Editor options
require("config.lazy")     -- Plugin manager bootstrap + plugin loading
require("config.keymaps")  -- General key mappings
require("config.autocmds") -- Autocommands
