-- ============================================================================
--  LSP — Mason + vim.lsp.config (Neovim 0.11+) + diagnostics
-- ============================================================================

return {
    -- ── Mason: portable LSP / DAP / linter / formatter manager ─────────────
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed   = "✓",
                    package_pending     = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- ── nvim-lspconfig: provides server configs in lsp/ ────────────────────
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- ── Diagnostic appearance ──────────────────────────────────────
            vim.diagnostic.config({
                virtual_text = { prefix = "●", source = "if_many" },
                float        = { source = true, border = "rounded" },
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

            -- ── Keymaps: set when any LSP attaches to a buffer ─────────────
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
                callback = function(ev)
                    local bufnr  = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- Disable hover for Ruff in favour of Pyright
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end

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
                    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, o("Prev diagnostic"))
                    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count =  1 }) end, o("Next diagnostic"))
                end,
            })

            -- ── Global capabilities (apply to every server) ────────────────
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- ── Server-specific configurations ─────────────────────────────

            -- Python — Pyright (type checking + intellisense)
            vim.lsp.config("pyright", {
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

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime     = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace   = {
                            library         = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry   = { enable = false },
                        completion  = { callSnippet = "Replace" },
                    },
                },
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
                },
            })
        end,
    },

    -- ── Bridge: auto-install & auto-enable servers ─────────────────────────
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
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
            -- Automatically calls vim.lsp.enable() for all installed servers
            automatic_enable = true,
        },
    },
}
