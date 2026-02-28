-- ============================================================================
--  General key mappings (non-plugin)
--  Plugin-specific keymaps live inside each plugin spec file.
-- ============================================================================

local map = vim.keymap.set

-- ─── Better escape ─────────────────────────────────────────────────────────
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- ─── Save / Quit ───────────────────────────────────────────────────────────
map("n", "<leader>w",  "<cmd>w<CR>",   { desc = "Save file" })
map("n", "<leader>W",  "<cmd>wa<CR>",  { desc = "Save all" })
map("n", "<leader>q",  "<cmd>q<CR>",   { desc = "Quit" })
map("n", "<leader>Q",  "<cmd>qa!<CR>", { desc = "Force quit all" })

-- ─── Window navigation ────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ─── Resize windows ───────────────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- ─── Split windows ────────────────────────────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=",          { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<CR>",  { desc = "Close split" })

-- ─── Buffers ───────────────────────────────────────────────────────────────
map("n", "<leader>bd", "<cmd>bdelete<CR>",  { desc = "Close buffer" })
map("n", "<leader>bD", "<cmd>%bdelete<CR>", { desc = "Close all buffers" })

-- ─── Move lines in visual mode ─────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- ─── Stay centered on scroll / search ──────────────────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n",     "nzzzv",   { desc = "Next search (centered)" })
map("n", "N",     "Nzzzv",   { desc = "Prev search (centered)" })

-- ─── Paste / Yank helpers ──────────────────────────────────────────────────
map("x",          "<leader>p", [["_dP]],  { desc = "Paste without override register" })
map({ "n", "v" }, "<leader>y", [["+y]],   { desc = "Yank to system clipboard" })
map("n",          "<leader>Y", [["+Y]],   { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>D", [["_d]],   { desc = "Delete without yank" })

-- ─── Clear search highlight ────────────────────────────────────────────────
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ─── Select all ────────────────────────────────────────────────────────────
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ─── Better indenting (stay in visual) ─────────────────────────────────────
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ─── Quickfix navigation ──────────────────────────────────────────────────
map("n", "]q", "<cmd>cnext<CR>",  { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>",  { desc = "Prev quickfix" })
map("n", "]l", "<cmd>lnext<CR>",  { desc = "Next loclist" })
map("n", "[l", "<cmd>lprev<CR>",  { desc = "Prev loclist" })
