-- ============================================================================
--  Autocommands
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ─── Highlight on yank ─────────────────────────────────────────────────────
autocmd("TextYankPost", {
    group = augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- ─── Remove trailing whitespace on save ────────────────────────────────────
autocmd("BufWritePre", {
    group = augroup("trim_whitespace", { clear = true }),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- ─── Auto-resize splits when terminal is resized ──────────────────────────
autocmd("VimResized", {
    group = augroup("resize_splits", { clear = true }),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- ─── Return to last edit position ──────────────────────────────────────────
autocmd("BufReadPost", {
    group = augroup("last_position", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ─── Close certain filetypes with 'q' ─────────────────────────────────────
autocmd("FileType", {
    group = augroup("close_with_q", { clear = true }),
    pattern = {
        "help", "lspinfo", "man", "notify", "qf",
        "startuptime", "checkhealth", "spectre_panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- ─── Python-specific settings ──────────────────────────────────────────────
autocmd("FileType", {
    group = augroup("python_settings", { clear = true }),
    pattern = "python",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        vim.opt_local.colorcolumn = "88"
    end,
})

-- ─── Web-dev settings (2-space indent) ─────────────────────────────────────
autocmd("FileType", {
    group = augroup("web_settings", { clear = true }),
    pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact",
                "html", "css", "json", "yaml", "lua", "vue", "svelte" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- ─── Auto-create parent dirs when saving ───────────────────────────────────
autocmd("BufWritePre", {
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
