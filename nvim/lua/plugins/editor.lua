-- ============================================================================
--  Editor utilities — auto-pairs, comments, surround, illuminate, trouble
-- ============================================================================

return {
    -- ── Auto pairs ─────────────────────────────────────────────────────────
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true,
                ts_config = {
                    lua    = { "string", "source" },
                    python = { "string" },
                },
            })
            -- CMP integration
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- ── Comment toggling ───────────────────────────────────────────────────
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("ts_context_commentstring").setup({ enable_autocmd = false })
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    -- ── Surround operations ────────────────────────────────────────────────
    {
        "kylechui/nvim-surround",
        version = "*",
        event   = "VeryLazy",
        config  = function() require("nvim-surround").setup() end,
    },

    -- ── Illuminate (highlight all occurrences of word under cursor) ────────
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                delay = 200,
                large_file_cutoff = 2000,
                large_file_overrides = { providers = { "lsp" } },
                filetypes_denylist = { "NvimTree", "toggleterm", "lazy", "mason", "alpha" },
            })
        end,
    },

    -- ── Trouble (pretty diagnostics / quickfix list) ───────────────────────
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        config = function()
            require("trouble").setup()
            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",               { desc = "Diagnostics (Trouble)" })
            vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",  { desc = "Buffer diagnostics" })
            vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                    { desc = "Location list" })
            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                    { desc = "Quickfix list" })
        end,
    },

    -- ── Fugitive (git commands inside Neovim) ──────────────────────────────
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gstatus", "Gblame", "Gpush", "Gpull" },
    },

    -- ── Markdown preview ───────────────────────────────────────────────────
    {
        "iamcco/markdown-preview.nvim",
        cmd   = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft    = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown preview" })
        end,
    },
}
