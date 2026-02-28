#!/usr/bin/env bash
# ============================================================================
#  nvim-custom — Uninstaller
#  Removes the Neovim configuration deployed by install.sh
# ============================================================================
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${RED}${BOLD}  ⚠  Neovim IDE — Uninstaller${NC}"
echo ""
echo "  This will remove:"
echo "    • ~/.config/nvim        (configuration)"
echo "    • ~/.local/share/nvim   (plugins & Mason tools)"
echo "    • ~/.local/state/nvim   (state files)"
echo "    • ~/.cache/nvim         (cache)"
echo ""
echo "  This will NOT remove:"
echo "    • Neovim binary (/opt/nvim)"
echo "    • Nerd Font (~/.local/share/fonts/JetBrainsMono)"
echo "    • Node.js, Python tools, lazygit"
echo ""

read -rp "  Are you sure? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "  ${YELLOW}Aborted.${NC}"
    exit 0
fi

echo ""
for dir in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
    if [[ -d "$dir" ]]; then
        rm -rf "$dir"
        echo -e "  ${GREEN}✓${NC} Removed $dir"
    else
        echo -e "  ${YELLOW}—${NC} Not found: $dir"
    fi
done

echo ""
echo -e "  ${GREEN}${BOLD}Done.${NC} Neovim configuration has been removed."
echo ""
echo "  To also remove the Neovim binary:"
echo "    sudo rm -rf /opt/nvim /usr/local/bin/nvim"
echo ""
echo "  To remove the Nerd Font:"
echo "    rm -rf ~/.local/share/fonts/JetBrainsMono && fc-cache -fv"
echo ""
echo "  To restore a backup (if any):"
echo "    mv ~/.config/nvim.backup.XXXXXXXX ~/.config/nvim"
echo ""
