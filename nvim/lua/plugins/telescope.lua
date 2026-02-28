-- ============================================================================
--  Telescope — fuzzy finder
-- ============================================================================

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local actions   = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<C-k>"]  = actions.move_selection_previous,
                            ["<C-j>"]  = actions.move_selection_next,
                            ["<C-q>"]  = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<esc>"]  = actions.close,
                        },
                    },
                    file_ignore_patterns = {
                        "node_modules", ".git/", "__pycache__",
                        "%.pyc", ".venv", "venv", "%.egg%-info",
                    },
                },
                pickers = {
                    find_files = { hidden = true },
                },
                extensions = {
                    fzf = {
                        fuzzy                   = true,
                        override_generic_sorter = true,
                        override_file_sorter    = true,
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")

            -- Keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files,   { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,    { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,      { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,    { desc = "Help tags" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles,     { desc = "Recent files" })
            vim.keymap.set("n", "<leader>fs", builtin.grep_string,  { desc = "Find string under cursor" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics,  { desc = "Find diagnostics" })
            vim.keymap.set("n", "<leader>fc", builtin.git_commits,  { desc = "Git commits" })
            vim.keymap.set("n", "<leader>fS", builtin.git_status,   { desc = "Git status" })
        end,
    },
}
