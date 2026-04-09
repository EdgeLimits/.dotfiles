# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# source ~/.local/share/omarchy/default/bash/rc

export PATH=$HOME/bin:/usr/local/bin:$PATH

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"

alias dotfiles="cd $HOME/.dotfiles && nvim ."
alias healper="cd ~/Development/healper/healper_dev"
alias dev="cd ~/Development"

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
