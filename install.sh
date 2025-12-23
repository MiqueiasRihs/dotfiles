#!/bin/bash

echo "🚀 Iniciando Setup..."

# 1. Instalar Pacotes Básicos
echo "📦 Instalando DNF packages..."
sudo dnf install -y zsh git neovim ulauncher grim slurp wl-clipboard git-delta

# 2. Instalar Flatpaks
echo "📦 Instalando Flatpaks..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Verifica se a lista existe antes de tentar instalar
if [ -f flatpak-list.txt ]; then
    xargs flatpak install -y flathub < flatpak-list.txt
else
    echo "⚠️ Aviso: flatpak-list.txt não encontrado. Pulei esta etapa."
fi

# 3. Linkar Configurações (Dotfiles)
echo "🔗 Criando Symlinks..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
mkdir -p ~/.config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# 4. Configurar VS Code
echo "📝 Configurando VS Code..."
mkdir -p ~/.config/Code/User/snippets
cp ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
cp ~/dotfiles/vscode/productivity.code-snippets ~/.config/Code/User/snippets/
# Instalar extensões (se a lista existir)
if [ -f vscode-extensions.txt ]; then
    cat vscode-extensions.txt | xargs -L 1 code --install-extension
fi

# 5. Restaurar GNOME (Atalhos, Tema, Pano)
echo "🖥️ Restaurando configurações do GNOME..."
if [ -f gnome-settings.ini ]; then
    dconf load / < gnome-settings.ini
fi

echo "✅ Setup Concluído! Reinicie a máquina."