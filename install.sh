#!/bin/bash

echo "🚀 Iniciando Setup Estruturado do Miquéias..."

# 1. Repositórios e Pacotes do Sistema (DNF)
echo "📦 Configurando repositórios e instalando pacotes..."
# Habilita COPR para o scrcpy conforme sua necessidade
sudo dnf copr enable -y zeno/scrcpy
sudo dnf install -y zsh git neovim ulauncher grim slurp wl-clipboard \
                    git-delta nodejs npm golang cmake ninja-build gtk3-devel \
                    clang pkg-config android-tools scrcpy \
                    kernel-devel-$(uname -r) kernel-headers-$(uname -r)

# 2. Instalar Flatpaks
echo "📦 Instalando Flatpaks..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
if [ -f flatpak-list.txt ]; then
    xargs flatpak install -y flathub < flatpak-list.txt
else
    echo "⚠️ Aviso: flatpak-list.txt não encontrado. Pulei esta etapa."
fi

# 3. Configuração de Grupos e Segurança (Essencial para Docker/KVM)
echo "👥 Configurando grupos e permissões..."
sudo usermod -aG docker $USER
sudo usermod -aG kvm $USER
# Ajuste de segurança para permitir que o container gerencie recursos necessários
sudo setsebool -P container_manage_cgroup on

# 4. Linkar Configurações (Dotfiles)
echo "🔗 Criando Symlinks..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
mkdir -p ~/.config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# 5. Configurar VS Code
echo "📝 Configurando VS Code..."
mkdir -p ~/.config/Code/User/snippets
cp ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
cp ~/dotfiles/vscode/productivity.code-snippets ~/.config/Code/User/snippets/
if [ -f vscode-extensions.txt ]; then
    cat vscode-extensions.txt | xargs -L 1 code --install-extension
fi

# 6. Ambiente Android On-Demand (Redroid)
echo "🤖 Preparando o motor do Redroid..."
# Montar Binderfs (o coração do Android no Linux)
sudo mkdir -p /dev/binderfs
sudo mount -t binder binder /dev/binderfs 2>/dev/null || echo "Binderfs já pronto."

# Criar o container (Configurado para NÃO iniciar sozinho)
docker rm -f redroid 2>/dev/null
docker run -d \
    --name redroid \
    --privileged \
    --restart no \
    -p 5555:5555 \
    -v /dev/binderfs:/dev/binderfs \
    redroid/redroid:11.0.0-latest

# 7. Restaurar GNOME
echo "🖥️ Restaurando configurações do GNOME..."
if [ -f gnome-settings.ini ]; then
    dconf load / < gnome-settings.ini
fi

echo "✅ Setup Concluído! Reinicie a máquina para aplicar grupos e módulos."