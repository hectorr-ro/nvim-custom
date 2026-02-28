#!/usr/bin/env bash
# ============================================================================
#  nvim-custom — Automated Neovim IDE Installer for Debian/Ubuntu
#  Full IDE setup oriented to Python development with multi-language support
#  Theme: Dracula | Font: JetBrainsMono Nerd Font | Copilot ready
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
NVIM_DATA_DIR="${HOME}/.local/share/nvim"
NVIM_STATE_DIR="${HOME}/.local/state/nvim"
NVIM_CACHE_DIR="${HOME}/.cache/nvim"
FONT_DIR="${HOME}/.local/share/fonts"
NERD_FONT="JetBrainsMono"

# ─── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ─── Logging helpers ────────────────────────────────────────────────────────
info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
success() { echo -e "${GREEN}[  ✓ ]${NC}  $1"; }
warn()    { echo -e "${YELLOW}[ !! ]${NC}  $1"; }
fail()    { echo -e "${RED}[  ✗ ]${NC}  $1"; exit 1; }
step()    { echo -e "\n${PURPLE}${BOLD}━━━ $1 ━━━${NC}"; }

# ─── Banner ──────────────────────────────────────────────────────────────────
banner() {
    echo -e "${PURPLE}${BOLD}"
    cat << 'EOF'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║     ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗                 ║
    ║     ████╗  ██║ ██║   ██║ ██║ ████╗ ████║                 ║
    ║     ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║                 ║
    ║     ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║                 ║
    ║     ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║                 ║
    ║     ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝                 ║
    ║                                                           ║
    ║       🐍  Python-First IDE  •  Multi-Language Support     ║
    ║       🎨  Dracula Theme     •  GitHub Copilot Ready       ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

EOF
    echo -e "${NC}"
}

# ─── 1. Check system ────────────────────────────────────────────────────────
check_system() {
    step "Checking system compatibility"

    if [[ ! -f /etc/debian_version ]] && ! grep -qi "debian\|ubuntu\|mint\|pop" /etc/os-release 2>/dev/null; then
        fail "This script is designed for Debian/Ubuntu-based systems only."
    fi

    ARCH="$(uname -m)"
    case "$ARCH" in
        x86_64)  NVIM_ARCH="x86_64" ;;
        aarch64) NVIM_ARCH="arm64"  ;;
        *)       fail "Unsupported architecture: $ARCH" ;;
    esac

    local os_name
    os_name="$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')" || os_name="Debian $(cat /etc/debian_version)"
    success "System: ${os_name} (${ARCH})"
}

# ─── 2. Install system dependencies ─────────────────────────────────────────
install_dependencies() {
    step "Installing system dependencies"

    info "Updating package lists..."
    sudo apt-get update -qq

    local packages=(
        git curl wget unzip tar gzip
        build-essential cmake
        python3 python3-pip python3-venv python3-dev
        ripgrep fd-find
        xclip
        fontconfig
    )

    info "Installing packages: ${packages[*]}"
    sudo apt-get install -y "${packages[@]}" 2>&1 | tail -3

    # fd-find binary is called 'fdfind' on Debian — create symlink so
    # Telescope and other tools can find it as 'fd'
    if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
        sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
        info "Created symlink: fd → fdfind"
    fi

    success "System dependencies installed"
}

# ─── 3. Install Node.js (needed by Mason, Copilot, some LSPs) ──────────────
install_nodejs() {
    step "Installing Node.js"

    if command -v node &>/dev/null; then
        local node_major
        node_major="$(node --version | tr -d 'v' | cut -d. -f1)"
        if [[ "$node_major" -ge 18 ]]; then
            success "Node.js $(node --version) already installed (>= 18)"
            return
        fi
        warn "Node.js version too old ($(node --version)), upgrading…"
    fi

    info "Setting up NodeSource LTS repository..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs 2>&1 | tail -2

    success "Node.js installed: $(node --version)"
}

# ─── 4. Install Neovim (latest stable from GitHub releases) ─────────────────
install_neovim() {
    step "Installing Neovim (latest stable)"

    # Check if a recent enough version is already installed
    if command -v nvim &>/dev/null; then
        local current_ver
        current_ver="$(nvim --version | head -1 | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')"
        local current_minor
        current_minor="$(echo "$current_ver" | cut -d. -f2)"
        if [[ "$current_minor" -ge 10 ]]; then
            success "Neovim v${current_ver} already installed (>= 0.10)"
            return
        fi
        warn "Neovim version too old (v${current_ver}), upgrading…"
    fi

    local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz"
    local tmp_dir
    tmp_dir="$(mktemp -d)"

    info "Downloading Neovim for ${NVIM_ARCH}..."
    curl -L --progress-bar -o "${tmp_dir}/nvim.tar.gz" "$nvim_url"

    info "Installing to /opt/nvim..."
    sudo rm -rf /opt/nvim
    sudo mkdir -p /opt/nvim
    sudo tar -xzf "${tmp_dir}/nvim.tar.gz" -C /opt/nvim --strip-components=1

    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

    rm -rf "$tmp_dir"

    success "Neovim installed: $(nvim --version | head -1)"
}

# ─── 5. Install JetBrainsMono Nerd Font ─────────────────────────────────────
install_font() {
    step "Installing JetBrainsMono Nerd Font"

    if fc-list | grep -qi "JetBrainsMono.*Nerd" 2>/dev/null; then
        success "JetBrainsMono Nerd Font already installed"
        return
    fi

    mkdir -p "$FONT_DIR"

    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${NERD_FONT}.zip"
    local tmp_dir
    tmp_dir="$(mktemp -d)"

    info "Downloading JetBrainsMono Nerd Font..."
    curl -L --progress-bar -o "${tmp_dir}/font.zip" "$font_url"

    info "Extracting font files..."
    unzip -o "${tmp_dir}/font.zip" -d "${FONT_DIR}/${NERD_FONT}" >/dev/null 2>&1

    info "Updating font cache..."
    fc-cache -fv >/dev/null 2>&1

    rm -rf "$tmp_dir"

    success "JetBrainsMono Nerd Font installed"
    warn "⚠  You must set 'JetBrainsMono Nerd Font' in your terminal emulator settings"
}

# ─── 6. Install Python provider + tools ─────────────────────────────────────
install_python_tools() {
    step "Installing Python tools"

    # pynvim is required for Neovim's Python 3 provider
    info "Installing pynvim (Neovim Python provider)..."
    python3 -m pip install --user pynvim 2>/dev/null \
        || python3 -m pip install --user --break-system-packages pynvim 2>/dev/null \
        || warn "Could not install pynvim via pip. Install it manually."

    success "Python tools ready (linters/formatters will be installed via Mason)"
}

# ─── 7. Install lazygit ─────────────────────────────────────────────────────
install_lazygit() {
    step "Installing lazygit"

    if command -v lazygit &>/dev/null; then
        success "lazygit already installed"
        return
    fi

    local lg_version
    lg_version="$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
                  | grep -Po '"tag_name":\s*"v\K[^"]*')" || true

    if [[ -z "$lg_version" ]]; then
        warn "Could not determine lazygit version. Skipping (optional)."
        return
    fi

    # lazygit uses x86_64 / arm64
    local lg_arch="$ARCH"
    [[ "$ARCH" == "aarch64" ]] && lg_arch="arm64"

    local lg_url="https://github.com/jesseduffield/lazygit/releases/download/v${lg_version}/lazygit_${lg_version}_Linux_${lg_arch}.tar.gz"
    local tmp_dir
    tmp_dir="$(mktemp -d)"

    info "Downloading lazygit v${lg_version}..."
    curl -L --progress-bar -o "${tmp_dir}/lazygit.tar.gz" "$lg_url"

    tar -xzf "${tmp_dir}/lazygit.tar.gz" -C "${tmp_dir}"
    sudo install "${tmp_dir}/lazygit" /usr/local/bin/

    rm -rf "$tmp_dir"

    success "lazygit installed: v${lg_version}"
}

# ─── 8. Deploy Neovim configuration ─────────────────────────────────────────
setup_config() {
    step "Deploying Neovim configuration"

    # Backup existing config / data / state / cache
    for dir in "$NVIM_CONFIG_DIR" "$NVIM_DATA_DIR" "$NVIM_STATE_DIR" "$NVIM_CACHE_DIR"; do
        if [[ -d "$dir" ]]; then
            local backup="${dir}.backup.$(date +%Y%m%d_%H%M%S)"
            warn "Existing dir found: $dir → backing up to $backup"
            mv "$dir" "$backup"
        fi
    done

    info "Copying configuration to ${NVIM_CONFIG_DIR}..."
    cp -r "${SCRIPT_DIR}/nvim" "$NVIM_CONFIG_DIR"

    success "Neovim configuration deployed"
}

# ─── 9. Sync plugins & Mason tools ──────────────────────────────────────────
sync_plugins() {
    step "Syncing plugins (this may take a minute…)"

    info "Running lazy.nvim sync..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

    info "Installing Mason tools (LSPs, formatters, linters)..."
    # Give Mason a moment, then run MasonToolsInstallSync
    nvim --headless -c "sleep 3" -c "MasonToolsInstallSync" -c "sleep 10" -c "qa!" 2>/dev/null || true

    success "Plugins and tools synced"
}

# ─── 10. Post-install summary ───────────────────────────────────────────────
post_install() {
    echo ""
    echo -e "${GREEN}${BOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║             ✅  Installation Complete!                     ║${NC}"
    echo -e "${GREEN}${BOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${BOLD}${CYAN}1. Set your terminal font${NC}"
    echo -e "     Change your terminal font to ${YELLOW}JetBrainsMono Nerd Font${NC}"
    echo -e "     (Settings vary by terminal: GNOME Terminal, Alacritty, Kitty…)"
    echo ""
    echo -e "  ${BOLD}${CYAN}2. Authenticate GitHub Copilot${NC}"
    echo -e "     Open Neovim and run:  ${YELLOW}:Copilot auth${NC}"
    echo -e "     A browser window will open — follow the instructions to log in."
    echo -e "     (Requires a GitHub Copilot subscription)"
    echo ""
    echo -e "  ${BOLD}${CYAN}3. Launch Neovim${NC}"
    echo -e "     ${YELLOW}nvim${NC}"
    echo -e "     On first launch Mason may install remaining servers in the background."
    echo ""
    echo -e "  ${BOLD}${CYAN}4. Health check${NC}"
    echo -e "     Inside Neovim:  ${YELLOW}:checkhealth${NC}"
    echo ""
    echo -e "  ${PURPLE}💡 Press ${YELLOW}Space${PURPLE} in Normal mode to see all keymaps (WhichKey)${NC}"
    echo -e "  ${PURPLE}📖 Read ${YELLOW}README.md${PURPLE} for the full shortcuts guide${NC}"
    echo ""
}

# ─── Main ────────────────────────────────────────────────────────────────────
main() {
    banner
    check_system
    install_dependencies
    install_nodejs
    install_neovim
    install_font
    install_python_tools
    install_lazygit
    setup_config
    sync_plugins
    post_install
}

main "$@"
