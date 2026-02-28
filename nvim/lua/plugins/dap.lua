-- ============================================================================
--  DAP — Debug Adapter Protocol (debugger)
-- ============================================================================

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap   = require("dap")
            local dapui = require("dapui")

            -- DAP UI
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size     = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size     = 10,
                        position = "bottom",
                    },
                },
            })

            -- Virtual text for variables
            require("nvim-dap-virtual-text").setup()

            -- Python adapter (uses debugpy, installed via Mason)
            require("dap-python").setup("python3")

            -- Auto open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open()  end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

            -- Breakpoint signs
            vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",          linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })

            -- Keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,                                           { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end,  { desc = "Conditional breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue,       { desc = "Continue" })
            vim.keymap.set("n", "<leader>di", dap.step_into,      { desc = "Step into" })
            vim.keymap.set("n", "<leader>do", dap.step_over,      { desc = "Step over" })
            vim.keymap.set("n", "<leader>dO", dap.step_out,       { desc = "Step out" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle,    { desc = "Toggle REPL" })
            vim.keymap.set("n", "<leader>dl", dap.run_last,       { desc = "Run last" })
            vim.keymap.set("n", "<leader>du", dapui.toggle,       { desc = "Toggle DAP UI" })
            vim.keymap.set("n", "<leader>dx", dap.terminate,      { desc = "Terminate" })
        end,
    },
}
