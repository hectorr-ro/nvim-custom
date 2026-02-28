-- ============================================================================
--  Dracula color scheme
-- ============================================================================

return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("dracula").setup({
                show_end_of_buffer = true,
                transparent_bg = false,
                italic_comment = true,
                overrides = {},
            })
            vim.cmd.colorscheme("dracula")
        end,
    },
}
