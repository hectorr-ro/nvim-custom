-- ============================================================================
--  LSP — Mason + lspconfig + diagnostics
-- ============================================================================

return {
    -- ── Mason: portable LSP / DAP / linter / formatter manager ─────────────
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed   = "✓",
                        package_pending     = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- ── Bridge between Mason and lspconfig ─────────────────────────────────
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",         -- Python type checker
                    "ruff",            -- Python linter/formatter (fast)
                    "lua_ls",          -- Lua
                    "ts_ls",           -- TypeScript / JavaScript
                    "rust_analyzer",   -- Rust
                    "clangd",          -- C / C++
                    "bashls",          -- Bash
                    "html",            -- HTML
                    "cssls",           -- CSS
                    "jsonls",          -- JSON
                    "yamlls",          -- YAML
                    "dockerls",        -- Dockerfile
                    "taplo",           -- TOML
                },
                automatic_installation = true,
            })
        end,
    },

    -- ── nvim-lspconfig ─────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_lsp   = require("cmp_nvim_lsp")
            local capabilities = cmp_lsp.default_capabilities()

            -- ── Diagnostic appearance ──────────────────────────────────────
            vim.diagnostic.config({
                virtual_text = { prefix = "●", source = "if_many" },
                float        = { source = "always", border = "rounded" },
                signs        = true,
                underline    = true,
                update_in_insert = false,
                severity_sort    = true,
            })

            local signs = {
                Error = " ", Warn = " ", Hint = "󰌵 ", Info = " ",
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- ── on_attach: keymaps available when an LSP attaches ──────────
            local on_attach = function(_, bufnr)
                local o = function(desc) return { buffer = bufnr, silent = true, desc = desc } end

                vim.keymap.set("n", "gd",          vim.lsp.buf.definition,      o("Go to definition"))
                vim.keymap.set("n", "gD",          vim.lsp.buf.declaration,     o("Go to declaration"))
                vim.keymap.set("n", "gi",          vim.lsp.buf.implementation,  o("Go to implementation"))
                vim.keymap.set("n", "gr",          vim.lsp.buf.references,      o("Go to references"))
                vim.keymap.set("n", "K",           vim.lsp.buf.hover,           o("Hover documentation"))
                vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action,     o("Code action"))
                vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename,          o("Rename symbol"))
                vim.keymap.set("n", "<leader>ld",  vim.diagnostic.open_float,   o("Line diagnostics"))
                vim.keymap.set("n", "<leader>ls",  vim.lsp.buf.signature_help,  o("Signature help"))
                vim.keymap.set("n", "<leader>lt",  vim.lsp.buf.type_definition, o("Type definition"))
                vim.keymap.set("n", "[d",          vim.diagnostic.goto_prev,    o("Prev diagnostic"))
                vim.keymap.set("n", "]d",          vim.diagnostic.goto_next,    o("Next diagnostic"))
            end

            -- ── Server configurations ──────────────────────────────────────

            -- Python — Pyright (type checking + intellisense)
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode       = "basic",
                            autoImportCompletions  = true,
                            diagnosticMode         = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            -- Python — Ruff (linting, fast)
            lspconfig.ruff.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Disable hover in favour of Pyright
                    client.server_capabilities.hoverProvider = false
                    on_attach(client, bufnr)
                end,
            })

            -- Lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime     = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace   = {
                            library        = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry   = { enable = false },
                        completion  = { callSnippet = "Replace" },
                    },
                },
            })

            -- TypeScript / JavaScript
            lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- Rust
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
                },
            })

            -- C / C++
            lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })

            -- Bash
            lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- HTML
            lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })

            -- CSS
            lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- JSON
            lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- YAML
            lspconfig.yamlls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- Docker
            lspconfig.dockerls.setup({ capabilities = capabilities, on_attach = on_attach })

            -- TOML
            lspconfig.taplo.setup({ capabilities = capabilities, on_attach = on_attach })
        end,
    },
}
