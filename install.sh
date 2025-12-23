#!/bin/bash

echo "🚀 Iniciando Setup do Miquéias..."

# 1. Instalar Pacotes Básicos
echo "📦 Instalando DNF packages..."
sudo dnf install -y zsh git neovim ulauncher grim slurp wl-clipboard

# 2. Instalar Flatpaks
echo "📦 Instalando Flatpaks..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
xargs flatpak install -y flathub < flatpak-list.txt

# 3. Linkar Configurações (Dotfiles)
echo "🔗 Criando Symlinks..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
mkdir -p ~/.config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# 4. Configurar VS Code
echo "📝 Configurando VS Code..."
mkdir -p ~/.config/Code/User/snippets
cp ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
cp ~/dotfiles/vscode/productivity.code-snippets ~/.config/Code/User/snippets/
# Instalar extensões
cat vscode-extensions.txt | xargs -L 1 code --install-extension

# 5. Restaurar GNOME (Atalhos, Tema, Pano)
echo "🖥️ Restaurando configurações do GNOME..."
dconf load / < gnome-settings.ini

echo "✅ Setup Concluído! Reinicie a máquina."