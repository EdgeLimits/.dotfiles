# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# brew install starship
eval "$(starship init zsh)"

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export NVM_DIR="$HOME/.nvm"


alias dotfiles="sh $HOME/.local/scripts/dotfiles.sh"

env-pyenv(){
  # make sure pyenv is installed (brew install pyenv)
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
}

env-nvm(){
  # make sure nvm is installed (brew install nvm)
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

src(){
  if [[ -d "venv/bin" ]]; then
    source venv/bin/activate
  fi
  if [[ -f ".env" ]]; then
    source .env
  fi
}

PERSONAL=$HOME/.config/personal
if [ -d "$PERSONAL" ]; then
  for i in `find -L $PERSONAL`; do
      source $i
  done
fi

WORK=$HOME/.config/work
if [ -d "$WORK" ]; then
  for i in `find -L $WORK`; do
      source $i
  done
fi

