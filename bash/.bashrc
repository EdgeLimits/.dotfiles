# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# source ~/.local/share/omarchy/default/bash/rc

export PATH=$HOME/bin:/usr/local/bin:$PATH

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"

alias dotfiles="cd $HOME/.dotfiles && nvim ."
healper() {
  case "$1" in
    server) cd ~/Development/healper/healper_server ;;
    dev)    cd ~/Development/healper/healper_dev ;;
    agent)  cd ~/Development/healper/healper_agent ;;
    *)      cd ~/Development/healper ;;
  esac
}
alias dev="cd ~/Development"

shrine() {
  case "$1" in
    api) cd ~/Development/shrine/shrine-api ;;
    app) cd ~/Development/shrine/shrine-app ;;
    *)   cd ~/Development/shrine ;;
  esac
}

ssh-init() {
  eval "$(ssh-agent -s)"
}

env-pyenv() {
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init >/dev/null; then eval "$(pyenv virtualenv-init -)"; fi
}

env-nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

src() {
  if [[ -d "venv/bin" ]]; then
    source venv/bin/activate
  fi
  if [[ -f ".env" ]]; then
    source .env
  fi
}

export PATH="$HOME/.local/bin:$PATH"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Brave profiles
alias brave-edgelimits='brave --profile-directory=EdgeLimits'
alias brave-healper='brave --profile-directory=Healper'
