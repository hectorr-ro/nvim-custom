# 🧛 nvim-custom — Neovim IDE para Desarrollo

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.10%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white" />
  <img src="https://img.shields.io/badge/Dracula-Theme-BD93F9?style=for-the-badge&logo=draculatheme&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-First-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub%20Copilot-Ready-000?style=for-the-badge&logo=githubcopilot&logoColor=white" />
  <img src="https://img.shields.io/badge/Debian%2FUbuntu-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
</p>

Configuración automatizada de **Neovim como IDE completo**, orientada principalmente al desarrollo en **Python** pero con soporte multi-lenguaje. Incluye tema **Dracula** oscuro, fuente **JetBrainsMono Nerd Font**, **GitHub Copilot**, autocompletado inteligente, depurador integrado, formateadores, linters y mucho más.

---

## ✨ Características

| Categoría | Detalle |
|-----------|---------|
| 🎨 **Tema** | Dracula oscuro con colores optimizados |
| 🔤 **Fuente** | JetBrainsMono Nerd Font (iconos incluidos) |
| 🐍 **Python** | Pyright + Ruff (LSP), Black + isort (formato), mypy (tipos), debugpy (depuración) |
| 🌐 **Multi-lenguaje** | TypeScript, Rust, C/C++, Go, Java, Bash, HTML, CSS, JSON, YAML, Docker, TOML |
| 🤖 **GitHub Copilot** | Integrado con el menú de autocompletado (nvim-cmp) |
| 📝 **Autocompletado** | nvim-cmp con snippets, LSP, paths, buffer y Copilot |
| 🔍 **Búsqueda** | Telescope (fuzzy finder para archivos, texto, git, diagnósticos) |
| 📁 **Explorador** | nvim-tree (sidebar con iconos y estado git) |
| 🐛 **Depurador** | nvim-dap + UI + breakpoints visuales (Python listo) |
| ✅ **Linting** | En tiempo real con nvim-lint + Ruff LSP |
| 🧹 **Formato** | Auto-formato al guardar con conform.nvim |
| 🔀 **Git** | gitsigns (hunks, blame), vim-fugitive, lazygit integrado |
| 💻 **Terminal** | Terminales flotantes, horizontales, verticales + Python REPL |
| 📊 **UI** | Dashboard, bufferline, lualine, noice, which-key, indent guides |
| 🎯 **Treesitter** | Syntax highlighting avanzado + text objects + selección incremental |

---

## 📋 Requisitos Previos

- **Sistema operativo:** Debian, Ubuntu, Linux Mint, Pop!\_OS o derivados
- **Arquitectura:** x86\_64 o ARM64
- **Acceso sudo** para instalar paquetes del sistema
- **Conexión a internet** para descargar dependencias
- **Git** (se instala automáticamente si no está presente)

### Opcional

- **Suscripción a GitHub Copilot** (para usar el asistente de IA)
- **lazygit** (se instala automáticamente)

---

## 🚀 Instalación Rápida

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/nvim-custom.git
cd nvim-custom

# 2. Dar permisos de ejecución
chmod +x install.sh uninstall.sh

# 3. Ejecutar el instalador
./install.sh
```

El script realizará automáticamente:

1. ✅ Verificar compatibilidad del sistema (Debian/Ubuntu)
2. ✅ Instalar dependencias del sistema (git, curl, build-essential, ripgrep, fd-find…)
3. ✅ Instalar Node.js LTS (requerido por algunos LSP y Copilot)
4. ✅ Instalar Neovim (última versión estable desde GitHub)
5. ✅ Instalar JetBrainsMono Nerd Font
6. ✅ Instalar pynvim (proveedor de Python para Neovim)
7. ✅ Instalar lazygit (interfaz git en terminal)
8. ✅ Hacer backup de configuración existente (si la hay)
9. ✅ Desplegar la configuración de Neovim
10. ✅ Sincronizar plugins e instalar herramientas vía Mason

---

## ⚙️ Pasos Post-Instalación

### 1. Configurar la fuente del terminal

Debes cambiar la fuente de tu emulador de terminal a **JetBrainsMono Nerd Font** para que los iconos se muestren correctamente.

| Terminal | Cómo cambiar la fuente |
|----------|----------------------|
| **GNOME Terminal** | Preferences → Profile → Custom font → `JetBrainsMono Nerd Font 12` |
| **Konsole** | Settings → Edit Profile → Appearance → Font → `JetBrainsMono Nerd Font` |
| **Alacritty** | Añadir en `~/.config/alacritty/alacritty.toml`: `[font.normal]` → `family = "JetBrainsMono Nerd Font"` |
| **Kitty** | Añadir en `~/.config/kitty/kitty.conf`: `font_family JetBrainsMono Nerd Font` |
| **Tilix** | Preferences → Profile → Font → `JetBrainsMono Nerd Font` |
| **Windows Terminal** | Settings → Profile → Appearance → Font → `JetBrainsMono Nerd Font` |

### 2. Autenticar GitHub Copilot

> ⚠️ Requiere una suscripción activa a [GitHub Copilot](https://github.com/features/copilot).

```
1. Abre Neovim:
   $ nvim

2. Ejecuta el comando de autenticación:
   :Copilot auth

3. Se abrirá una ventana del navegador con un código de verificación.

4. Inicia sesión en GitHub y pega el código cuando se te solicite.

5. Regresa a Neovim — Copilot estará activo.

6. Verifica el estado:
   :Copilot status
```

### 3. Verificar la instalación

```
1. Abre Neovim:
   $ nvim

2. Ejecuta el health check:
   :checkhealth

3. Revisa que no haya errores críticos en:
   - Provider (Python, Node.js)
   - Treesitter
   - LSP
   - Mason
```

### 4. Primera vez usando Mason

En el primer inicio, Mason descargará e instalará automáticamente los servidores LSP, formateadores y linters configurados. Puedes ver el progreso con:

```
:Mason
```

---

## 🔌 Plugins Incluidos

### Core

| Plugin | Descripción |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Gestor de plugins moderno y rápido |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Tema Dracula oscuro |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Iconos para archivos |

### LSP & Autocompletado

| Plugin | Descripción |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuración de servidores LSP |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Instalador portable de LSP/DAP/Linters/Formatters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Puente Mason ↔ lspconfig |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-instalación de herramientas |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletado |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | Fuente LSP para cmp |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Fuente buffer para cmp |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Fuente rutas de archivo |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Autocompletado en línea de comandos |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Motor de snippets |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets estilo VS Code |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | Iconos en el menú de autocompletado |

### GitHub Copilot

| Plugin | Descripción |
|--------|-------------|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Cliente de Copilot en Lua |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) | Integración Copilot → nvim-cmp |

### Sintaxis & Navegación

| Plugin | Descripción |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting avanzado |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects para funciones, clases, parámetros |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder universal |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Algoritmo FZF nativo para Telescope |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Explorador de archivos lateral |

### Formato & Linting

| Plugin | Descripción |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formateador (black, isort, prettier, stylua…) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linter asíncrono (mypy, eslint, shellcheck…) |

### Git

| Plugin | Descripción |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Indicadores git, blame, hunks |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Comandos git dentro de Neovim |

### Depuración

| Plugin | Descripción |
|--------|-------------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Interfaz gráfica para DAP |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Configuración DAP para Python |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | Valores de variables inline |

### UI & Experiencia

| Plugin | Descripción |
|--------|-------------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Barra de estado (Dracula) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Pestañas de buffers |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard de inicio |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI mejorada para mensajes/cmdline |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notificaciones bonitas |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Cheatsheet de atajos en tiempo real |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Guías de indentación |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Previsualización de colores inline |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Resaltado de TODO, FIXME, HACK… |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminales integradas |

### Editor

| Plugin | Descripción |
|--------|-------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Cierre automático de paréntesis, comillas… |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comentar/descomentar con `gc` |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Operaciones con delimitadores (cambiar, borrar, añadir) |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | Resaltar palabra bajo el cursor |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Lista de diagnósticos mejorada |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Preview de Markdown en el navegador |

---

## Servidores LSP Instalados

| Servidor | Lenguaje |
|----------|----------|
| `pyright` | Python (tipos + intellisense) |
| `ruff` | Python (linting rápido) |
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

## ⌨️ Guía de Atajos de Teclado

> **Tecla líder (Leader):** `Espacio`
>
> **Modos:** `N` = Normal, `I` = Insert, `V` = Visual, `T` = Terminal, `X` = Visual block, `O` = Operator

### General

| Atajo | Modo | Acción |
|-------|------|--------|
| `jk` / `jj` | I | Salir del modo inserción |
| `<leader>w` | N | Guardar archivo |
| `<leader>W` | N | Guardar todos los archivos |
| `<leader>q` | N | Cerrar ventana |
| `<leader>Q` | N | Forzar cierre de todo |
| `<leader>nh` | N | Limpiar resaltado de búsqueda |
| `<C-a>` | N | Seleccionar todo |
| `u` | N | Deshacer |
| `<C-r>` | N | Rehacer |

### Navegación de Ventanas

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-h>` | N | Mover a ventana izquierda |
| `<C-j>` | N | Mover a ventana inferior |
| `<C-k>` | N | Mover a ventana superior |
| `<C-l>` | N | Mover a ventana derecha |
| `<C-Up>` | N | Aumentar altura |
| `<C-Down>` | N | Reducir altura |
| `<C-Left>` | N | Reducir anchura |
| `<C-Right>` | N | Aumentar anchura |

### Splits (Divisiones)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>sv` | N | Split vertical |
| `<leader>sh` | N | Split horizontal |
| `<leader>se` | N | Igualar tamaño de splits |
| `<leader>sx` | N | Cerrar split actual |

### Buffers (Pestañas)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Tab>` | N | Buffer siguiente |
| `<S-Tab>` | N | Buffer anterior |
| `<leader>bd` | N | Cerrar buffer |
| `<leader>bD` | N | Cerrar todos los buffers |
| `<leader>bp` | N | Fijar/Desfijar buffer |
| `<leader>bo` | N | Cerrar los demás buffers |

### Explorador de Archivos (nvim-tree)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>e` | N | Abrir/cerrar explorador |
| `<leader>E` | N | Enfocar explorador |
| `a` | — | Crear archivo/directorio (dentro del explorador) |
| `d` | — | Eliminar archivo (dentro del explorador) |
| `r` | — | Renombrar archivo (dentro del explorador) |
| `x` | — | Cortar archivo |
| `c` | — | Copiar archivo |
| `p` | — | Pegar archivo |

### Búsqueda (Telescope)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>ff` | N | Buscar archivos |
| `<leader>fg` | N | Buscar texto (live grep) |
| `<leader>fb` | N | Buscar buffers abiertos |
| `<leader>fh` | N | Buscar en ayuda |
| `<leader>fr` | N | Archivos recientes |
| `<leader>fs` | N | Buscar palabra bajo el cursor |
| `<leader>fd` | N | Buscar diagnósticos |
| `<leader>fc` | N | Commits de git |
| `<leader>fS` | N | Estado de git |
| `<leader>ft` | N | Buscar TODOs |

### LSP (Language Server Protocol)

| Atajo | Modo | Acción |
|-------|------|--------|
| `gd` | N | Ir a la definición |
| `gD` | N | Ir a la declaración |
| `gi` | N | Ir a la implementación |
| `gr` | N | Ver referencias |
| `K` | N | Documentación hover |
| `<leader>ca` | N | Acción de código (code action) |
| `<leader>rn` | N | Renombrar símbolo |
| `<leader>ld` | N | Diagnósticos de la línea |
| `<leader>ls` | N | Ayuda de firma (signature help) |
| `<leader>lt` | N | Ir a definición de tipo |
| `[d` | N | Diagnóstico anterior |
| `]d` | N | Diagnóstico siguiente |

### Formato y Linting

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>lf` | N/V | Formatear archivo o selección |
| `<leader>ll` | N | Ejecutar linting manualmente |
| *(auto)* | — | Formato automático al guardar |
| *(auto)* | — | Linting al entrar/guardar/salir de inserción |

### Git

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>gg` | N | Abrir lazygit (interfaz git completa) |
| `<leader>gp` | N | Previsualizar hunk |
| `<leader>gs` | N | Añadir hunk al stage |
| `<leader>gr` | N | Revertir hunk |
| `<leader>gS` | N | Añadir buffer completo al stage |
| `<leader>gR` | N | Revertir buffer completo |
| `<leader>gb` | N | Mostrar blame de la línea |
| `<leader>gd` | N | Diff del archivo |
| `]h` | N | Siguiente hunk |
| `[h` | N | Hunk anterior |

### Terminal

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-\>` | N | Abrir/cerrar terminal flotante |
| `<leader>tf` | N | Terminal flotante |
| `<leader>th` | N | Terminal horizontal |
| `<leader>tv` | N | Terminal vertical |
| `<leader>tp` | N | REPL de Python |
| `<Esc>` | T | Salir del modo terminal |
| `<C-h/j/k/l>` | T | Navegar entre ventanas desde terminal |

### Depuración (DAP)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>db` | N | Poner/quitar breakpoint |
| `<leader>dB` | N | Breakpoint condicional |
| `<leader>dc` | N | Continuar ejecución |
| `<leader>di` | N | Step into (entrar en función) |
| `<leader>do` | N | Step over (siguiente línea) |
| `<leader>dO` | N | Step out (salir de función) |
| `<leader>dr` | N | Abrir/cerrar REPL del debugger |
| `<leader>dl` | N | Ejecutar última sesión de debug |
| `<leader>du` | N | Abrir/cerrar UI del debugger |
| `<leader>dx` | N | Terminar sesión de debug |

### Autocompletado (nvim-cmp)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-Space>` | I | Abrir menú de autocompletado |
| `<CR>` (Enter) | I | Confirmar selección |
| `<Tab>` | I | Siguiente item / expandir snippet |
| `<S-Tab>` | I | Item anterior |
| `<C-b>` | I | Scroll arriba en documentación |
| `<C-f>` | I | Scroll abajo en documentación |
| `<C-e>` | I | Cerrar menú de autocompletado |

### Edición

| Atajo | Modo | Acción |
|-------|------|--------|
| `gc` | N/V | Comentar/descomentar (toggle) |
| `gcc` | N | Comentar/descomentar línea |
| `J` | V | Mover línea(s) hacia abajo |
| `K` | V | Mover línea(s) hacia arriba |
| `<` | V | Reducir indentación (mantiene selección) |
| `>` | V | Aumentar indentación (mantiene selección) |
| `<leader>p` | X | Pegar sin perder el registro |
| `<leader>y` | N/V | Copiar al portapapeles del sistema |
| `<leader>Y` | N | Copiar línea al portapapeles |
| `<leader>D` | N/V | Borrar sin guardar en registro |

### Treesitter (Text Objects)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-Space>` | N | Iniciar/incrementar selección |
| `<BS>` | N | Decrementar selección |
| `af` / `if` | O/V | Seleccionar función (outer/inner) |
| `ac` / `ic` | O/V | Seleccionar clase (outer/inner) |
| `aa` / `ia` | O/V | Seleccionar parámetro (outer/inner) |
| `]m` / `[m` | N | Siguiente/anterior función |
| `]]` / `[[` | N | Siguiente/anterior clase |
| `<leader>a` | N | Intercambiar parámetro con siguiente |
| `<leader>A` | N | Intercambiar parámetro con anterior |

### Diagnósticos (Trouble)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>xx` | N | Toggle lista de diagnósticos |
| `<leader>xd` | N | Diagnósticos del buffer actual |
| `<leader>xl` | N | Location list |
| `<leader>xq` | N | Quickfix list |

### Surround (Delimitadores)

| Atajo | Modo | Acción |
|-------|------|--------|
| `ys{motion}{char}` | N | Añadir delimitador (ej: `ysiw"` → rodea palabra con `"`) |
| `ds{char}` | N | Borrar delimitador (ej: `ds"` → quita `"`) |
| `cs{old}{new}` | N | Cambiar delimitador (ej: `cs"'` → cambia `"` por `'`) |

### Navegación Rápida

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-d>` | N | Scroll media página abajo (centrado) |
| `<C-u>` | N | Scroll media página arriba (centrado) |
| `n` / `N` | N | Siguiente/anterior resultado de búsqueda (centrado) |
| `]q` / `[q` | N | Siguiente/anterior quickfix |
| `]l` / `[l` | N | Siguiente/anterior location list |

### WhichKey

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Space>` | N | Muestra TODOS los atajos disponibles |

> 💡 **Tip:** Presiona `<Space>` y espera — **WhichKey** mostrará un panel con todos los atajos organizados por categoría.

---

## 🐍 Características Específicas para Python

- **Pyright** como servidor LSP principal para Python: autocompletado, go-to-definition, renombrado inteligente, diagnósticos de tipo
- **Ruff** como linter LSP: extremadamente rápido, reemplaza flake8/pylint
- **Black** como formateador (88 columnas por defecto)
- **isort** para organizar imports automáticamente
- **mypy** para verificación estricta de tipos
- **debugpy** para depuración paso a paso con UI integrada
- Línea guía en columna 88 (estándar Black)
- Indentación de 4 espacios automática
- REPL de Python accesible con `<leader>tp`
- Soporte para virtualenvs (Pyright los detecta automáticamente)

### Configurar un virtualenv

```bash
# Crear virtualenv
python3 -m venv .venv

# Activarlo antes de abrir Neovim
source .venv/bin/activate

# Abrir Neovim — Pyright detectará el venv automáticamente
nvim
```

---

## 🎨 Personalización

### Cambiar el tema

Edita `~/.config/nvim/lua/plugins/theme.lua` y cambia el plugin/colorscheme.

### Añadir un nuevo servidor LSP

1. Añádelo a la lista en `~/.config/nvim/lua/plugins/lsp.lua` → `ensure_installed`
2. Configúralo con `lspconfig.nombre.setup({ ... })`

### Añadir un formateador/linter

1. Añádelo a `~/.config/nvim/lua/plugins/lint-format.lua` → `ensure_installed` (Mason)
2. Configúralo en `formatters_by_ft` (conform) o `linters_by_ft` (nvim-lint)

### Cambiar la indentación

Edita `~/.config/nvim/lua/config/options.lua` → `tabstop` y `shiftwidth`.

### Gestionar plugins

```vim
:Lazy              " Abrir gestor de plugins
:Lazy sync         " Sincronizar plugins
:Lazy update       " Actualizar plugins
:Lazy clean        " Limpiar plugins no usados
:Mason             " Abrir gestor de herramientas
```

---

## 🔧 Solución de Problemas

### Los iconos no se ven correctamente

→ Asegúrate de haber configurado **JetBrainsMono Nerd Font** como fuente de tu terminal.

### Copilot no funciona

```vim
:Copilot status    " Verificar estado
:Copilot auth      " Re-autenticar
:checkhealth       " Verificar que Node.js está disponible
```

### Un servidor LSP no se instala

```vim
:Mason             " Abrir Mason
:MasonLog          " Ver logs de instalación
```

### El formato no se aplica al guardar

```vim
:ConformInfo       " Ver qué formateador se usa para el archivo actual
```

### Errores al iniciar Neovim por primera vez

Es normal que en el primer inicio haya algunos errores mientras se instalan los plugins y herramientas. Cierra y vuelve a abrir Neovim.

### TreeSitter: parser no disponible

```vim
:TSInstall <lenguaje>    " Instalar parser manualmente
:TSUpdate                " Actualizar todos los parsers
```

---

## 🗑️ Desinstalación

```bash
# Desde el directorio del repositorio
./uninstall.sh
```

Esto elimina la configuración, plugins y datos de Neovim. **No** desinstala Neovim, la fuente ni las herramientas del sistema.

Para una desinstalación completa:

```bash
# Eliminar Neovim
sudo rm -rf /opt/nvim /usr/local/bin/nvim

# Eliminar la fuente
rm -rf ~/.local/share/fonts/JetBrainsMono && fc-cache -fv

# Eliminar lazygit
sudo rm -f /usr/local/bin/lazygit
```

---

## 📂 Estructura del Proyecto

```
nvim-custom/
├── install.sh                    # Script de instalación principal
├── uninstall.sh                  # Script de desinstalación
├── README.md                     # Este archivo
├── .gitignore
└── nvim/                         # Configuración de Neovim
    ├── init.lua                  # Punto de entrada
    └── lua/
        ├── config/
        │   ├── options.lua       # Opciones del editor
        │   ├── keymaps.lua       # Atajos generales
        │   ├── autocmds.lua      # Autocommands
        │   └── lazy.lua          # Bootstrap de lazy.nvim
        └── plugins/
            ├── theme.lua         # Dracula
            ├── treesitter.lua    # Syntax highlighting
            ├── lsp.lua           # LSP + Mason
            ├── cmp.lua           # Autocompletado
            ├── telescope.lua     # Fuzzy finder
            ├── nvim-tree.lua     # Explorador de archivos
            ├── lualine.lua       # Barra de estado
            ├── bufferline.lua    # Pestañas de buffers
            ├── gitsigns.lua      # Git decorations
            ├── toggleterm.lua    # Terminal integrada
            ├── copilot.lua       # GitHub Copilot
            ├── dap.lua           # Debugger
            ├── lint-format.lua   # Formateo + Linting
            ├── ui.lua            # Dashboard, indent, noice, which-key
            └── editor.lua        # Auto-pairs, comments, surround, trouble
```

---

## 📜 Licencia

MIT — Usa, modifica y comparte libremente.

---

<p align="center">
  Hecho con 💜 para desarrolladores Python (y no solo Python)
</p>
