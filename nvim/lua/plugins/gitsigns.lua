-- ============================================================================
--  gitsigns — git decorations & hunk actions
-- ============================================================================

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "│" },
                    change       = { text = "│" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    delay          = 500,
                    virt_text_pos  = "eol",
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local o  = function(desc) return { buffer = bufnr, desc = desc } end

                    vim.keymap.set("n", "]h",          gs.next_hunk,     o("Next hunk"))
                    vim.keymap.set("n", "[h",          gs.prev_hunk,     o("Prev hunk"))
                    vim.keymap.set("n", "<leader>gp",  gs.preview_hunk,  o("Preview hunk"))
                    vim.keymap.set("n", "<leader>gs",  gs.stage_hunk,    o("Stage hunk"))
                    vim.keymap.set("n", "<leader>gr",  gs.reset_hunk,    o("Reset hunk"))
                    vim.keymap.set("n", "<leader>gS",  gs.stage_buffer,  o("Stage buffer"))
                    vim.keymap.set("n", "<leader>gR",  gs.reset_buffer,  o("Reset buffer"))
                    vim.keymap.set("n", "<leader>gb",  gs.blame_line,    o("Blame line"))
                    vim.keymap.set("n", "<leader>gd",  gs.diffthis,      o("Diff this"))
                end,
            })
        end,
    },
}
