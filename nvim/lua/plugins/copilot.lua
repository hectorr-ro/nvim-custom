-- ============================================================================
--  GitHub Copilot — AI pair programmer
--  After installation run  :Copilot auth  to authenticate.
-- ============================================================================

return {
    -- Copilot core (Lua rewrite)
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false }, -- using copilot-cmp instead
                panel      = { enabled = false }, -- using copilot-cmp instead
                filetypes = {
                    yaml       = true,
                    markdown   = true,
                    help       = false,
                    gitcommit  = true,
                    gitrebase  = false,
                    ["."]      = false,
                },
            })
        end,
    },

    -- Copilot completion source for nvim-cmp
    {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
