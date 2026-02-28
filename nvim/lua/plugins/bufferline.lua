-- ============================================================================
--  bufferline — buffer tabs at the top
-- ============================================================================

return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    themable = true,
                    numbers = "none",
                    close_command = "bdelete! %d",
                    indicator     = { style = "icon", icon = "▎" },
                    buffer_close_icon = "󰅖",
                    modified_icon     = "●",
                    close_icon        = "",
                    left_trunc_marker  = "",
                    right_trunc_marker = "",
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype  = "NvimTree",
                            text      = " Explorer",
                            highlight = "Directory",
                            separator = true,
                        },
                    },
                    show_buffer_icons       = true,
                    show_buffer_close_icons = true,
                    separator_style         = "thin",
                    always_show_bufferline  = true,
                },
            })

            vim.keymap.set("n", "<Tab>",       "<cmd>BufferLineCycleNext<CR>",             { desc = "Next buffer" })
            vim.keymap.set("n", "<S-Tab>",     "<cmd>BufferLineCyclePrev<CR>",             { desc = "Prev buffer" })
            vim.keymap.set("n", "<leader>bp",  "<cmd>BufferLineTogglePin<CR>",             { desc = "Pin buffer" })
            vim.keymap.set("n", "<leader>bP",  "<cmd>BufferLineGroupClose ungrouped<CR>",  { desc = "Close non-pinned" })
            vim.keymap.set("n", "<leader>bo",  "<cmd>BufferLineCloseOthers<CR>",           { desc = "Close others" })
        end,
    },
}
