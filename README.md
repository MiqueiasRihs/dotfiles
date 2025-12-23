# Meus Dotfiles

Este repositório contém meus arquivos de configuração pessoais, conhecidos como "dotfiles". O objetivo é automatizar a instalação e configuração do meu ambiente de desenvolvimento em sistemas Linux (com foco em distribuições baseadas no Fedora), garantindo consistência, portabilidade e agilidade ao migrar para uma nova máquina.

## 🚀 Sobre este Projeto

Manter um ambiente de desenvolvimento consistente em diferentes máquinas pode ser um desafio. Este projeto centraliza as configurações de ferramentas essenciais, pacotes e personalizações de interface, permitindo recriar meu ambiente de forma rápida e automatizada com um único script.

## 🛠️ O que está incluído?

As configurações neste repositório abrangem as seguintes ferramentas e sistemas:

-   **Shell**:
    -   `zsh` (`.zshrc`): Configurações personalizadas para o Zsh shell, incluindo aliases, funções e plugins.
    -   `starship` (`starship.toml`): Configuração do prompt cross-shell Starship, para uma linha de comando moderna e informativa.

-   **Editor de Código**:
    -   `Visual Studio Code` (`vscode/`):
        -   `settings.json`: Configurações do editor, como tema, fonte, e comportamento.
        -   `productivity.code-snippets`: Snippets de código para acelerar o desenvolvimento.
        -   `vscode-extensions.txt`: Uma lista de extensões recomendadas para backup e reinstalação.

-   **Terminal**:
    -   `Ghostty` (`ghostty/config`): Arquivo de configuração para o emulador de terminal Ghostty.

-   **Gerenciamento de Pacotes**:
    -   `dnf-packages.txt`: Lista de pacotes a serem instalados via `dnf` (para Fedora, CentOS, etc.).
    -   `flatpak-list.txt`: Lista de aplicações a serem instaladas via Flatpak.

-   **Ambiente Desktop**:
    -   `gnome-settings.ini`: Backup de configurações do ambiente desktop GNOME.

-   **Controle de Versão**:
    -   `.gitconfig`: Configurações globais do Git, como nome, email e aliases.

## ⚙️ Instalação

O script `install.sh` foi criado para automatizar o processo de setup, copiando os arquivos de configuração para os locais corretos e instalando os pacotes listados.

**Atenção**: Execute o script com cuidado, pois ele fará alterações no seu sistema e nos seus arquivos de configuração existentes. Recomendo ler o conteúdo do script antes de executá-lo.

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/dotfiles.git
    cd dotfiles
    ```

2.  **Execute o script de instalação:**
    ```bash
    ./install.sh
    ```

##  adapting️ Como Adaptar para Seu Uso

Se você deseja usar este repositório como base para seus próprios dotfiles, siga estes passos:

1.  **Faça um Fork** deste projeto.
2.  **Personalize os arquivos** de acordo com suas preferências:
    -   Atualize o `.gitconfig` com suas informações.
    -   Modifique as listas de pacotes (`dnf-packages.txt`, `flatpak-list.txt`) e extensões (`vscode-extensions.txt`).
    -   Ajuste as configurações do VS Code, Zsh, Starship, etc.
3.  **Revise e adapte** o script `install.sh` para garantir que ele atenda às suas necessidades.
