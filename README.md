# 🧛 nvim-custom — Neovim IDE for Development

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.10%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white" />
  <img src="https://img.shields.io/badge/Dracula-Theme-BD93F9?style=for-the-badge&logo=draculatheme&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-First-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub%20Copilot-Ready-000?style=for-the-badge&logo=githubcopilot&logoColor=white" />
  <img src="https://img.shields.io/badge/Debian%2FUbuntu-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
</p>

Automated **Neovim as a full-featured IDE** setup, primarily oriented towards **Python** development with multi-language support. Includes **Dracula** dark theme, **JetBrainsMono Nerd Font**, **GitHub Copilot**, intelligent autocompletion, integrated debugger, formatters, linters, and much more.

---

## ✨ Features

| Category | Details |
|----------|---------|
| 🎨 **Theme** | Dracula dark with optimized colors |
| 🔤 **Font** | JetBrainsMono Nerd Font (icons included) |
| 🐍 **Python** | Pyright + Ruff (LSP), Black + isort (formatting), mypy (types), debugpy (debugging) |
| 🌐 **Multi-language** | TypeScript, Rust, C/C++, Go, Java, Bash, HTML, CSS, JSON, YAML, Docker, TOML |
| 🤖 **GitHub Copilot** | Integrated with the autocompletion menu (nvim-cmp) |
| 📝 **Autocompletion** | nvim-cmp with snippets, LSP, paths, buffer, and Copilot |
| 🔍 **Search** | Telescope (fuzzy finder for files, text, git, diagnostics) |
| 📁 **Explorer** | nvim-tree (sidebar with icons and git status) |
| 🐛 **Debugger** | nvim-dap + UI + visual breakpoints (Python ready) |
| ✅ **Linting** | Real-time with nvim-lint + Ruff LSP |
| 🧹 **Formatting** | Auto-format on save with conform.nvim |
| 🔀 **Git** | gitsigns (hunks, blame), vim-fugitive, lazygit integrated |
| 💻 **Terminal** | Floating, horizontal, vertical terminals + Python REPL |
| 📊 **UI** | Dashboard, bufferline, lualine, noice, which-key, indent guides |
| 🎯 **Treesitter** | Advanced syntax highlighting + text objects + incremental selection |

---

## 📋 Prerequisites

- **Operating system:** Debian, Ubuntu, Linux Mint, Pop!\_OS or derivatives
- **Architecture:** x86\_64 or ARM64
- **sudo access** to install system packages
- **Internet connection** to download dependencies
- **Git** (installed automatically if not present)

### Optional

- **GitHub Copilot subscription** (to use the AI assistant)
- **lazygit** (installed automatically)

---

## 🚀 Quick Installation

```bash
# 1. Clone the repository
git clone https://github.com/hectorr-ro/nvim-custom.git
cd nvim-custom

# 2. Make scripts executable
chmod +x install.sh uninstall.sh

# 3. Run the installer
./install.sh
```

The script will automatically:

1. ✅ Verify system compatibility (Debian/Ubuntu)
2. ✅ Install system dependencies (git, curl, build-essential, ripgrep, fd-find…)
3. ✅ Install Node.js LTS (required by some LSPs and Copilot)
4. ✅ Install Neovim (latest stable release from GitHub)
5. ✅ Install JetBrainsMono Nerd Font
6. ✅ Install pynvim (Neovim Python provider)
7. ✅ Install lazygit (terminal git UI)
8. ✅ Back up existing configuration (if any)
9. ✅ Deploy Neovim configuration
10. ✅ Sync plugins and install tools via Mason

---

## ⚙️ Post-Installation Steps

### 1. Set your terminal font

You must change your terminal emulator font to **JetBrainsMono Nerd Font** for icons to display correctly.

| Terminal | How to change the font |
|----------|----------------------|
| **GNOME Terminal** | Preferences → Profile → Custom font → `JetBrainsMono Nerd Font 12` |
| **Konsole** | Settings → Edit Profile → Appearance → Font → `JetBrainsMono Nerd Font` |
| **Alacritty** | Add to `~/.config/alacritty/alacritty.toml`: `[font.normal]` → `family = "JetBrainsMono Nerd Font"` |
| **Kitty** | Add to `~/.config/kitty/kitty.conf`: `font_family JetBrainsMono Nerd Font` |
| **Tilix** | Preferences → Profile → Font → `JetBrainsMono Nerd Font` |
| **Windows Terminal** | Settings → Profile → Appearance → Font → `JetBrainsMono Nerd Font` |

### 2. Authenticate GitHub Copilot

> ⚠️ Requires an active [GitHub Copilot](https://github.com/features/copilot) subscription.

```
1. Open Neovim:
   $ nvim

2. Run the authentication command:
   :Copilot auth

3. A browser window will open with a verification code.

4. Sign in to GitHub and paste the code when prompted.

5. Return to Neovim — Copilot will be active.

6. Verify status:
   :Copilot status
```

### 3. Verify the installation

```
1. Open Neovim:
   $ nvim

2. Run the health check:
   :checkhealth

3. Check that there are no critical errors in:
   - Provider (Python, Node.js)
   - Treesitter
   - LSP
   - Mason
```

### 4. First time using Mason

On the first launch, Mason will automatically download and install the configured LSP servers, formatters, and linters. You can check the progress with:

```
:Mason
```

---

## 🔌 Included Plugins

### Core

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern and fast plugin manager |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Dracula dark theme |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |

### LSP & Autocompletion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP server configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable LSP/DAP/Linter/Formatter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason ↔ lspconfig bridge |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP source for cmp |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer source for cmp |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File path source |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Command line autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | VS Code-style snippet collection |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | Icons in the autocompletion menu |

### GitHub Copilot

| Plugin | Description |
|--------|-------------|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot client in Lua |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | Copilot → nvim-cmp integration |

### Syntax & Navigation

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects for functions, classes, parameters |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Universal fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native FZF algorithm for Telescope |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Sidebar file explorer |

### Formatting & Linting

| Plugin | Description |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter (black, isort, prettier, stylua…) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linter (mypy, eslint, shellcheck…) |

### Git

| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git indicators, blame, hunks |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands inside Neovim |

### Debugging

| Plugin | Description |
|--------|-------------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Graphical DAP interface |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | DAP configuration for Python |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | Inline variable values |

### UI & Experience

| Plugin | Description |
|--------|-------------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status bar (Dracula) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Start dashboard |
| [noice.nvim](https://github.com/folke/noice.nvim) | Enhanced UI for messages/cmdline |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Pretty notifications |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Real-time keybinding cheatsheet |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Inline color preview |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO, FIXME, HACK… |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Integrated terminals |

### Editor

| Plugin | Description |
|--------|-------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes… |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments with `gc` |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround operations (change, delete, add) |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | Highlight word under cursor |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Enhanced diagnostics list |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown preview in browser |

---

## Installed LSP Servers

| Server | Language |
|--------|----------|
| `pyright` | Python (types + intellisense) |
| `ruff` | Python (fast linting) |
| `lua_ls` | Lua |
| `ts_ls` | TypeScript / JavaScript |
| `rust_analyzer` | Rust |
| `clangd` | C / C++ |
| `bashls` | Bash / Shell |
| `html` | HTML |
| `cssls` | CSS |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `dockerls` | Dockerfile |
| `taplo` | TOML |

---

## ⌨️ Keyboard Shortcuts Guide

> **Leader key:** `Space`
>
> **Modes:** `N` = Normal, `I` = Insert, `V` = Visual, `T` = Terminal, `X` = Visual block, `O` = Operator

### General

| Shortcut | Mode | Action |
|----------|------|--------|
| `jk` / `jj` | I | Exit insert mode |
| `<leader>w` | N | Save file |
| `<leader>W` | N | Save all files |
| `<leader>q` | N | Quit window |
| `<leader>Q` | N | Force quit all |
| `<leader>nh` | N | Clear search highlight |
| `<C-a>` | N | Select all |
| `u` | N | Undo |
| `<C-r>` | N | Redo |

### Window Navigation

| Shortcut | Mode | Action |
|----------|------|--------|
| `<C-h>` | N | Move to left window |
| `<C-j>` | N | Move to lower window |
| `<C-k>` | N | Move to upper window |
| `<C-l>` | N | Move to right window |
| `<C-Up>` | N | Increase height |
| `<C-Down>` | N | Decrease height |
| `<C-Left>` | N | Decrease width |
| `<C-Right>` | N | Increase width |

### Splits

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>sv` | N | Vertical split |
| `<leader>sh` | N | Horizontal split |
| `<leader>se` | N | Equalize split sizes |
| `<leader>sx` | N | Close current split |

### Buffers (Tabs)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<Tab>` | N | Next buffer |
| `<S-Tab>` | N | Previous buffer |
| `<leader>bd` | N | Close buffer |
| `<leader>bD` | N | Close all buffers |
| `<leader>bp` | N | Pin/Unpin buffer |
| `<leader>bo` | N | Close other buffers |

### File Explorer (nvim-tree)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>e` | N | Toggle file explorer |
| `<leader>E` | N | Focus file explorer |
| `a` | — | Create file/directory (inside explorer) |
| `d` | — | Delete file (inside explorer) |
| `r` | — | Rename file (inside explorer) |
| `x` | — | Cut file |
| `c` | — | Copy file |
| `p` | — | Paste file |

### Search (Telescope)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>ff` | N | Find files |
| `<leader>fg` | N | Live grep (search text) |
| `<leader>fb` | N | Find open buffers |
| `<leader>fh` | N | Search help tags |
| `<leader>fr` | N | Recent files |
| `<leader>fs` | N | Find string under cursor |
| `<leader>fd` | N | Find diagnostics |
| `<leader>fc` | N | Git commits |
| `<leader>fS` | N | Git status |
| `<leader>ft` | N | Find TODOs |

### LSP (Language Server Protocol)

| Shortcut | Mode | Action |
|----------|------|--------|
| `gd` | N | Go to definition |
| `gD` | N | Go to declaration |
| `gi` | N | Go to implementation |
| `gr` | N | View references |
| `K` | N | Hover documentation |
| `<leader>ca` | N | Code action |
| `<leader>rn` | N | Rename symbol |
| `<leader>ld` | N | Line diagnostics |
| `<leader>ls` | N | Signature help |
| `<leader>lt` | N | Go to type definition |
| `[d` | N | Previous diagnostic |
| `]d` | N | Next diagnostic |

### Formatting & Linting

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>lf` | N/V | Format file or selection |
| `<leader>ll` | N | Trigger linting manually |
| *(auto)* | — | Auto-format on save |
| *(auto)* | — | Lint on enter/save/leave insert |

### Git

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>gg` | N | Open lazygit (full git UI) |
| `<leader>gp` | N | Preview hunk |
| `<leader>gs` | N | Stage hunk |
| `<leader>gr` | N | Reset hunk |
| `<leader>gS` | N | Stage entire buffer |
| `<leader>gR` | N | Reset entire buffer |
| `<leader>gb` | N | Show line blame |
| `<leader>gd` | N | Diff this file |
| `]h` | N | Next hunk |
| `[h` | N | Previous hunk |

### Terminal

| Shortcut | Mode | Action |
|----------|------|--------|
| `<C-\>` | N | Toggle floating terminal |
| `<leader>tf` | N | Floating terminal |
| `<leader>th` | N | Horizontal terminal |
| `<leader>tv` | N | Vertical terminal |
| `<leader>tp` | N | Python REPL |
| `<Esc>` | T | Exit terminal mode |
| `<C-h/j/k/l>` | T | Navigate between windows from terminal |

### Debugging (DAP)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>db` | N | Toggle breakpoint |
| `<leader>dB` | N | Conditional breakpoint |
| `<leader>dc` | N | Continue execution |
| `<leader>di` | N | Step into |
| `<leader>do` | N | Step over |
| `<leader>dO` | N | Step out |
| `<leader>dr` | N | Toggle debugger REPL |
| `<leader>dl` | N | Run last debug session |
| `<leader>du` | N | Toggle DAP UI |
| `<leader>dx` | N | Terminate debug session |

### Autocompletion (nvim-cmp)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<C-Space>` | I | Open autocompletion menu |
| `<CR>` (Enter) | I | Confirm selection |
| `<Tab>` | I | Next item / expand snippet |
| `<S-Tab>` | I | Previous item |
| `<C-b>` | I | Scroll docs up |
| `<C-f>` | I | Scroll docs down |
| `<C-e>` | I | Close autocompletion menu |

### Editing

| Shortcut | Mode | Action |
|----------|------|--------|
| `gc` | N/V | Toggle comment |
| `gcc` | N | Toggle line comment |
| `J` | V | Move line(s) down |
| `K` | V | Move line(s) up |
| `<` | V | Decrease indent (keeps selection) |
| `>` | V | Increase indent (keeps selection) |
| `<leader>p` | X | Paste without overriding register |
| `<leader>y` | N/V | Yank to system clipboard |
| `<leader>Y` | N | Yank line to system clipboard |
| `<leader>D` | N/V | Delete without yanking |

### Treesitter (Text Objects)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<C-Space>` | N | Start/increment selection |
| `<BS>` | N | Decrement selection |
| `af` / `if` | O/V | Select function (outer/inner) |
| `ac` / `ic` | O/V | Select class (outer/inner) |
| `aa` / `ia` | O/V | Select parameter (outer/inner) |
| `]m` / `[m` | N | Next/previous function |
| `]]` / `[[` | N | Next/previous class |
| `<leader>a` | N | Swap parameter with next |
| `<leader>A` | N | Swap parameter with previous |

### Diagnostics (Trouble)

| Shortcut | Mode | Action |
|----------|------|--------|
| `<leader>xx` | N | Toggle diagnostics list |
| `<leader>xd` | N | Current buffer diagnostics |
| `<leader>xl` | N | Location list |
| `<leader>xq` | N | Quickfix list |

### Surround (Delimiters)

| Shortcut | Mode | Action |
|----------|------|--------|
| `ys{motion}{char}` | N | Add delimiter (e.g., `ysiw"` → surround word with `"`) |
| `ds{char}` | N | Delete delimiter (e.g., `ds"` → remove `"`) |
| `cs{old}{new}` | N | Change delimiter (e.g., `cs"'` → change `"` to `'`) |

### Quick Navigation

| Shortcut | Mode | Action |
|----------|------|--------|
| `<C-d>` | N | Scroll half page down (centered) |
| `<C-u>` | N | Scroll half page up (centered) |
| `n` / `N` | N | Next/previous search result (centered) |
| `]q` / `[q` | N | Next/previous quickfix |
| `]l` / `[l` | N | Next/previous location list |

### WhichKey

| Shortcut | Mode | Action |
|----------|------|--------|
| `<Space>` | N | Show ALL available keybindings |

> 💡 **Tip:** Press `<Space>` and wait — **WhichKey** will display a panel with all shortcuts organized by category.

---

## 🐍 Python-Specific Features

- **Pyright** as the main Python LSP server: autocompletion, go-to-definition, smart rename, type diagnostics
- **Ruff** as LSP linter: extremely fast, replaces flake8/pylint
- **Black** as formatter (88 columns by default)
- **isort** to organize imports automatically
- **mypy** for strict type checking
- **debugpy** for step-by-step debugging with integrated UI
- Guide line at column 88 (Black standard)
- Automatic 4-space indentation
- Python REPL accessible with `<leader>tp`
- Virtualenv support (Pyright detects them automatically)

### Setting up a virtualenv

```bash
# Create virtualenv
python3 -m venv .venv

# Activate it before opening Neovim
source .venv/bin/activate

# Open Neovim — Pyright will detect the venv automatically
nvim
```

---

## 🎨 Customization

### Change the theme

Edit `~/.config/nvim/lua/plugins/theme.lua` and change the plugin/colorscheme.

### Add a new LSP server

1. Add it to the list in `~/.config/nvim/lua/plugins/lsp.lua` → `ensure_installed`
2. Configure it with `lspconfig.name.setup({ ... })`

### Add a formatter/linter

1. Add it to `~/.config/nvim/lua/plugins/lint-format.lua` → `ensure_installed` (Mason)
2. Configure it in `formatters_by_ft` (conform) or `linters_by_ft` (nvim-lint)

### Change indentation

Edit `~/.config/nvim/lua/config/options.lua` → `tabstop` and `shiftwidth`.

### Manage plugins

```vim
:Lazy              " Open plugin manager
:Lazy sync         " Sync plugins
:Lazy update       " Update plugins
:Lazy clean        " Clean unused plugins
:Mason             " Open tool manager
```

---

## 🔧 Troubleshooting

### Icons don't display correctly

→ Make sure you have set **JetBrainsMono Nerd Font** as your terminal font.

### Copilot doesn't work

```vim
:Copilot status    " Check status
:Copilot auth      " Re-authenticate
:checkhealth       " Verify Node.js is available
```

### An LSP server won't install

```vim
:Mason             " Open Mason
:MasonLog          " View installation logs
```

### Format on save doesn't work

```vim
:ConformInfo       " See which formatter is used for the current file
```

### Errors on first Neovim launch

It's normal for the first launch to have some errors while plugins and tools are being installed. Close and reopen Neovim.

### TreeSitter: parser not available

```vim
:TSInstall <language>    " Install parser manually
:TSUpdate                " Update all parsers
```

---

## 🗑️ Uninstallation

```bash
# From the repository directory
./uninstall.sh
```

This removes the Neovim configuration, plugins, and data. It does **not** uninstall Neovim, the font, or system tools.

For a complete uninstallation:

```bash
# Remove Neovim
sudo rm -rf /opt/nvim /usr/local/bin/nvim

# Remove the font
rm -rf ~/.local/share/fonts/JetBrainsMono && fc-cache -fv

# Remove lazygit
sudo rm -f /usr/local/bin/lazygit
```

---

## 📂 Project Structure

```
nvim-custom/
├── install.sh                    # Main installation script
├── uninstall.sh                  # Uninstallation script
├── README.md                     # This file
├── .gitignore
└── nvim/                         # Neovim configuration
    ├── init.lua                  # Entry point
    └── lua/
        ├── config/
        │   ├── options.lua       # Editor options
        │   ├── keymaps.lua       # General keymaps
        │   ├── autocmds.lua      # Autocommands
        │   └── lazy.lua          # lazy.nvim bootstrap
        └── plugins/
            ├── theme.lua         # Dracula
            ├── treesitter.lua    # Syntax highlighting
            ├── lsp.lua           # LSP + Mason
            ├── cmp.lua           # Autocompletion
            ├── telescope.lua     # Fuzzy finder
            ├── nvim-tree.lua     # File explorer
            ├── lualine.lua       # Status bar
            ├── bufferline.lua    # Buffer tabs
            ├── gitsigns.lua      # Git decorations
            ├── toggleterm.lua    # Integrated terminal
            ├── copilot.lua       # GitHub Copilot
            ├── dap.lua           # Debugger
            ├── lint-format.lua   # Formatting + Linting
            ├── ui.lua            # Dashboard, indent, noice, which-key
            └── editor.lua        # Auto-pairs, comments, surround, trouble
```

---

## 📜 License

MIT — Use, modify, and share freely.

---

<p align="center">
  Made with 💜 for Python developers (and not only Python)
</p>
