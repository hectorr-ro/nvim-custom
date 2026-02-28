-- ============================================================================
--  Treesitter — syntax highlighting, text objects, incremental selection
-- ============================================================================

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    -- Primary
                    "python", "lua",
                    -- Web
                    "javascript", "typescript", "tsx", "html", "css",
                    -- Data / Config
                    "json", "yaml", "toml", "xml",
                    -- Systems
                    "c", "cpp", "rust", "go", "java",
                    -- Shell
                    "bash",
                    -- Docs
                    "markdown", "markdown_inline", "vimdoc", "regex",
                    -- Other
                    "dockerfile", "gitignore", "gitcommit", "sql",
                    "vim",
                },
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                indent = { enable = true },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection    = "<C-space>",
                        node_incremental  = "<C-space>",
                        scope_incremental = false,
                        node_decremental  = "<bs>",
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start     = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
                        goto_next_end       = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
                        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
                        goto_previous_end   = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
                    },
                    swap = {
                        enable = true,
                        swap_next     = { ["<leader>a"] = "@parameter.inner" },
                        swap_previous = { ["<leader>A"] = "@parameter.inner" },
                    },
                },
            })
        end,
    },
}
