-- ============================================================================
--  Editor options
-- ============================================================================

local opt = vim.opt

-- ─── Line numbers ───────────────────────────────────────────────────────────
opt.number         = true
opt.relativenumber = true

-- ─── Tabs & indentation ────────────────────────────────────────────────────
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.softtabstop = 4
opt.expandtab   = true
opt.autoindent  = true
opt.smartindent = true

-- ─── Line wrapping ─────────────────────────────────────────────────────────
opt.wrap = false

-- ─── Search ────────────────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- ─── Appearance ────────────────────────────────────────────────────────────
opt.termguicolors = true
opt.background    = "dark"
opt.signcolumn    = "yes"
opt.cursorline    = true
opt.colorcolumn   = "88"         -- PEP 8 / Black default line length
opt.showmode      = false        -- lualine shows the mode
opt.pumheight     = 10           -- completion menu height

-- ─── Backspace ─────────────────────────────────────────────────────────────
opt.backspace = "indent,eol,start"

-- ─── Clipboard ─────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus"

-- ─── Splits ────────────────────────────────────────────────────────────────
opt.splitright = true
opt.splitbelow = true

-- ─── Persistent undo ───────────────────────────────────────────────────────
opt.undofile = true
opt.undodir  = vim.fn.stdpath("data") .. "/undo"

-- ─── Scrolling ─────────────────────────────────────────────────────────────
opt.scrolloff     = 8
opt.sidescrolloff = 8

-- ─── Timing ────────────────────────────────────────────────────────────────
opt.updatetime  = 250
opt.timeoutlen  = 300

-- ─── Completion ────────────────────────────────────────────────────────────
opt.completeopt = "menuone,noselect"

-- ─── Mouse ─────────────────────────────────────────────────────────────────
opt.mouse = "a"

-- ─── File encoding ─────────────────────────────────────────────────────────
opt.encoding     = "utf-8"
opt.fileencoding = "utf-8"

-- ─── Swap / backup ────────────────────────────────────────────────────────
opt.swapfile    = false
opt.backup      = false
opt.writebackup = false

-- ─── Folding (via Treesitter, disabled by default) ─────────────────────────
opt.foldmethod = "expr"
opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false
opt.foldlevel  = 99
