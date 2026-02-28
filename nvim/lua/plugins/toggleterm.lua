-- ============================================================================
--  toggleterm — integrated terminal
-- ============================================================================

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then return 15 end
                    if term.direction == "vertical"   then return math.floor(vim.o.columns * 0.4) end
                end,
                open_mapping    = [[<C-\>]],
                hide_numbers    = true,
                shade_terminals = true,
                shading_factor  = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size    = true,
                direction       = "float",
                close_on_exit   = true,
                shell           = vim.o.shell,
                float_opts = {
                    border    = "curved",
                    winblend  = 0,
                },
            })

            local Terminal = require("toggleterm.terminal").Terminal

            -- Lazygit (requires lazygit installed)
            local lazygit = Terminal:new({
                cmd       = "lazygit",
                hidden    = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                    width  = function() return math.floor(vim.o.columns * 0.9) end,
                    height = function() return math.floor(vim.o.lines * 0.9) end,
                },
            })

            vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })

            -- Python REPL
            local python = Terminal:new({
                cmd       = "python3",
                hidden    = true,
                direction = "horizontal",
            })

            vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Python REPL" })

            -- Direction-specific toggles
            vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      { desc = "Float terminal" })
            vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",  { desc = "Horizontal terminal" })
            vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",    { desc = "Vertical terminal" })

            -- Terminal-mode keymaps (navigate out of terminal)
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]],        opts)
                vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<CR>]], opts)
                vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<CR>]], opts)
                vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<CR>]], opts)
                vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<CR>]], opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },
}
