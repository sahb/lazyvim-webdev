# Neovim + LazyVim Setup

Personal Neovim configuration based on [LazyVim](https://lazyvim.org), tested on Ubuntu 24.04.

---

## Prerequisites

### Node.js (via nvm)

Node.js is required for the Neovim Node provider and for installing npm-based tools. Installing via nvm avoids the need for root.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm install --lts
```

---

## 1. Neovim

The Neovim package in Ubuntu's default repositories is outdated. Install directly from the official release tarball, with no external dependencies.

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
nvim --version
rm nvim-linux-x86_64.tar.gz
```

To update in the future, just repeat the same steps — `ln -sf` overwrites the symlink automatically.

---

## 2. Fonts (Nerd Fonts)

Neovim uses the terminal's font. To correctly display LazyVim icons and symbols, install a Nerd Font and configure it in gnome-terminal.

```bash
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/JetBrainsMono
unzip JetBrainsMono.zip "JetBrainsMonoNerdFont-Regular.ttf" \
                        "JetBrainsMonoNerdFont-Bold.ttf" \
                        "JetBrainsMonoNerdFont-Italic.ttf" \
                        "JetBrainsMonoNerdFont-BoldItalic.ttf" \
                        -d ~/.local/share/fonts/JetBrainsMono
fc-cache -vf
fc-list | grep -i jetbrains
rm JetBrainsMono.zip
```

After installing, open gnome-terminal preferences → **Profiles → Text**, uncheck "Use the system fixed-width font" and select `JetBrainsMono Nerd Font` (no suffix).

---

## 3. Configuration

Clone this repository into the correct location. Remove any existing default config first.

```bash
rm -rf ~/.config/nvim
git clone https://github.com/sahb/lazyvim ~/.config/nvim
```

Open nvim and wait for LazyVim to automatically install all plugins.

---

## 4. Dependencies

External tools used by LazyVim, LSPs and formatters. `fzf` and `lazygit` are not available in their latest versions from Ubuntu 24.04's default repositories and must be installed directly from GitHub.

```bash
#!/bin/bash

echo "==> Installing system dependencies..."
sudo apt install -y \
    ripgrep \
    fd-find \
    python3-pip \
    php \
    php-cli \
    php-xml \
    composer

echo "==> Installing fzf..."
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar -xf /tmp/fzf.tar.gz -C /tmp fzf
sudo install /tmp/fzf /usr/local/bin/fzf
rm /tmp/fzf.tar.gz /tmp/fzf

echo "==> Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit
rm /tmp/lazygit.tar.gz /tmp/lazygit

echo "==> Installing neovim Node provider..."
npm install -g neovim

echo "==> Installing pint (PHP formatter)..."
composer global require --dev laravel/pint

echo "==> Verifying installations..."
echo -n "rg: "; rg --version | head -1
echo -n "fd: "; fdfind --version
echo -n "fzf: "; fzf --version
echo -n "lazygit: "; lazygit --version
echo -n "php: "; php --version | head -1
echo -n "composer: "; composer --version

echo ""
echo "==> Done! Open nvim and run :checkhealth to confirm."
```

### Composer PATH

Pint installed via `composer global require` is placed in `~/.config/composer/vendor/bin/`. Add it to your `~/.bashrc`:

```bash
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
```

---

## Optional dependencies

Install as needed:

- **Go, cargo, Ruby, Java** — depending on your project stack
- **black** — Python formatter: `pip install black`
- **pynvim** — update with: `pip install --upgrade pynvim --break-system-packages`
- **LaTeX/vimtex** — install `texlive` only if you use LaTeX

Can be safely ignored:

- **luarocks** — no installed plugin requires it
- **Snacks.image** — requires kitty, wezterm or ghostty terminal; does not work with gnome-terminal
- **Perl provider** — rarely needed

---
### Intelephense Premium
If you have an Intelephense Premium license, place it at the path below:
```shell
# Create the file with your key (replace with your actual key)
echo "YOUR_KEY_HERE" > ~/intelephense/licence.txt
```

