-- ============================================================================
--  nvim-tree — file explorer sidebar
-- ============================================================================

return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                filters = {
                    dotfiles = false,
                    custom   = { ".DS_Store", "__pycache__", ".git" },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                renderer = {
                    highlight_git = true,
                    icons = {
                        show = {
                            file         = true,
                            folder       = true,
                            folder_arrow = true,
                            git          = true,
                        },
                    },
                    indent_markers = { enable = true },
                },
                view = {
                    width = 35,
                    side  = "left",
                },
                actions = {
                    open_file = { quit_on_open = false },
                },
                update_focused_file = { enable = true },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
            vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<CR>",  { desc = "Focus file explorer" })
        end,
    },
}
