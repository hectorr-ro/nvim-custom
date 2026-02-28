-- ============================================================================
--  UI enhancements — dashboard, indent guides, noice, which-key, etc.
-- ============================================================================

return {
    -- ── Indent guides ──────────────────────────────────────────────────────
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main  = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "│", tab_char = "│" },
                scope  = { enabled = true, show_start = true, show_end = false },
                exclude = {
                    filetypes = {
                        "help", "dashboard", "alpha", "lazy",
                        "mason", "toggleterm", "NvimTree",
                    },
                },
            })
        end,
    },

    -- ── Dashboard ──────────────────────────────────────────────────────────
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha     = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[                                                    ]],
                [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
                [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
                [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
                [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
                [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
                [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                [[                                                    ]],
                [[          🐍  Python-First IDE  •  Dracula 🧛       ]],
                [[                                                    ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file",      "<cmd>Telescope find_files<CR>"),
                dashboard.button("r", "  Recent files",   "<cmd>Telescope oldfiles<CR>"),
                dashboard.button("g", "  Find text",      "<cmd>Telescope live_grep<CR>"),
                dashboard.button("n", "  New file",       "<cmd>ene <BAR> startinsert<CR>"),
                dashboard.button("c", "  Configuration",  "<cmd>e $MYVIMRC<CR>"),
                dashboard.button("l", "󰒲  Lazy",           "<cmd>Lazy<CR>"),
                dashboard.button("m", "  Mason",          "<cmd>Mason<CR>"),
                dashboard.button("q", "  Quit",           "<cmd>qa<CR>"),
            }

            dashboard.section.header.opts.hl  = "DraculaPurple"
            dashboard.section.buttons.opts.hl = "DraculaCyan"
            dashboard.section.footer.opts.hl  = "DraculaComment"

            vim.api.nvim_create_autocmd("User", {
                pattern  = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    dashboard.section.footer.val =
                        "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count
                        .. " plugins in " .. (math.floor(stats.startuptime * 100 + 0.5) / 100) .. " ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            alpha.setup(dashboard.opts)
        end,
    },

    -- ── Noice (better UI for messages / cmdline / popups) ──────────────────
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"]                = true,
                        ["cmp.entry.get_documentation"]                  = true,
                    },
                },
                presets = {
                    bottom_search         = true,
                    command_palette       = true,
                    long_message_to_split = true,
                    inc_rename            = true,
                },
            })
        end,
    },

    -- ── Which-Key (keybinding cheat-sheet) ─────────────────────────────────
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout    = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.setup({
                plugins = { marks = true, registers = true, spelling = { enabled = true } },
                win     = { border = "rounded" },
            })
            wk.add({
                { "<leader>f", group = "Find / Files" },
                { "<leader>g", group = "Git" },
                { "<leader>l", group = "LSP / Lint" },
                { "<leader>d", group = "Debug" },
                { "<leader>t", group = "Terminal" },
                { "<leader>b", group = "Buffer" },
                { "<leader>s", group = "Split" },
                { "<leader>x", group = "Trouble" },
            })
        end,
    },

    -- ── Colorizer (inline colour preview) ──────────────────────────────────
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    css      = true,
                    tailwind = true,
                    mode     = "background",
                },
            })
        end,
    },

    -- ── TODO comments ──────────────────────────────────────────────────────
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
            vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
        end,
    },
}
