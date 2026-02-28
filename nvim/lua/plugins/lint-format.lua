-- ============================================================================
--  Formatting (conform.nvim) + Linting (nvim-lint) + Mason tool installer
-- ============================================================================

return {
    -- ── Formatting ─────────────────────────────────────────────────────────
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd   = { "ConformInfo" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python           = { "black", "isort" },
                    javascript       = { "prettier" },
                    typescript       = { "prettier" },
                    javascriptreact  = { "prettier" },
                    typescriptreact  = { "prettier" },
                    html             = { "prettier" },
                    css              = { "prettier" },
                    json             = { "prettier" },
                    yaml             = { "prettier" },
                    markdown         = { "prettier" },
                    lua              = { "stylua" },
                    bash             = { "shfmt" },
                    sh               = { "shfmt" },
                    rust             = { "rustfmt" },
                },
                format_on_save = {
                    timeout_ms   = 3000,
                    lsp_fallback = true,
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>lf", function()
                require("conform").format({ lsp_fallback = true, timeout_ms = 3000 })
            end, { desc = "Format file / range" })
        end,
    },

    -- ── Linting ────────────────────────────────────────────────────────────
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python     = { "mypy" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                bash       = { "shellcheck" },
                sh         = { "shellcheck" },
            }

            local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group    = lint_group,
                callback = function() lint.try_lint() end,
            })

            vim.keymap.set("n", "<leader>ll", function() lint.try_lint() end, { desc = "Trigger linting" })
        end,
    },

    -- ── Mason tool installer (formatters, linters, debuggers) ──────────────
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Python
                    "black",
                    "isort",
                    "mypy",
                    "debugpy",
                    -- Web
                    "prettier",
                    "eslint_d",
                    -- Lua
                    "stylua",
                    -- Shell
                    "shellcheck",
                    "shfmt",
                },
                auto_update  = true,
                run_on_start = true,
            })
        end,
    },
}
