# =============================================================================
#  CONFIGURAÇÕES GERAIS
# =============================================================================
# Habilita cores no comando ls
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Define editor padrão (mude para 'vim' ou 'nano' se preferir)
export EDITOR='code --wait'

# Adiciona pastas locais ao PATH (bom para scripts pip, npm, go)
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# =============================================================================
#  HISTÓRICO INTELIGENTE
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY      # Adiciona ao histórico em vez de sobrescrever
setopt SHARE_HISTORY       # Compartilha histórico entre abas do Tilix instantaneamente
setopt HIST_IGNORE_DUPS    # Não grava comandos repetidos em sequência
setopt HIST_IGNORE_SPACE   # Comandos com espaço no início não vão para o histórico

# =============================================================================
#  AUTOCOMPLETE (Nativo do Zsh)
# =============================================================================
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' menu select # Menu de seleção visual com TAB


# =============================================================================
#  BINDKEYS UTEIS
# =============================================================================
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Ctrl + Left / Right → mover por palavra
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Alternativas (alguns terminais usam isso)
bindkey '^[[5D' backward-word
bindkey '^[[5C' forward-word

# =============================================================================
#  ALIASES (Atalhos de Produtividade)
# =============================================================================
# Sistema
alias update='sudo dnf update -y'
alias install='sudo dnf install'
alias cls='clear'

# Listagem melhorada
alias ll='ls -lAh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Git (essenciais)
alias lg='lazygit'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'

# Docker
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# CPU Performance
alias getmode='powerprofilesctl get'
alias performance='powerprofilesctl set performance'
alias balanced='powerprofilesctl set balanced'
alias powersaver='powerprofilesctl set power-saver'

# =============================================================================
#  PLUGINS
# =============================================================================
# Carrega zsh-autosuggestions (se instalado via dnf)
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Carrega zsh-syntax-highlighting (se instalado via dnf)
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# =============================================================================
#  FERRAMENTAS EXTRAS
# =============================================================================
# Inicializa o Zoxide (substituto turbo do 'cd')
eval "$(zoxide init zsh)"
alias cd='z'

# =============================================================================
#  DOTFILES UPDATED
# =============================================================================
update_dotfiles() {
    echo "📦 Atualizando listas de pacotes..."
    sudo dnf list installed | awk '{print $1}' > ~/dotfiles/dnf-packages.txt
    flatpak list --app --columns=application > ~/dotfiles/flatpak-list.txt
    code --list-extensions > ~/dotfiles/vscode-extensions.txt
    dconf dump / > ~/dotfiles/gnome-settings.ini

    echo "gitt Add, Commit & Push..."
    cd ~/dotfiles
    git add .
    git commit -m "update: sincronizando configurações e pacotes em $(date +'%Y-%m-%d')"
    git push
    cd - > /dev/null
    echo "✅ Dotfiles sincronizados com o GitHub!"
}

alias dotup="update_dotfiles"

# =============================================================================
#  PROMPT (Starship) - Deve ser sempre o último
# =============================================================================
eval "$(starship init zsh)"
