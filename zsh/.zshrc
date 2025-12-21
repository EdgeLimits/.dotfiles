# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

eval "$(starship init zsh)"

# # Activate syntax highlighting
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# (( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none
#
# # Activate autosuggestions
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export NVM_DIR="$HOME/.nvm"


alias dotfiles="cd $HOME/.dotfiles && nvim ."

ssh-init(){
  eval "$(ssh-agent -s)"
}

function check_ssh {
  [[ $3 =~ '\bssh\b' ]] || return
  [[ -n "$SSH_AGENT_PID" && -e "/proc/$SSH_AGENT_PID" ]] \
    && ssh-add -l >/dev/null && return
  eval `keychain --eval id_dsa --timeout 60`
}    
autoload -U add-zsh-hook
add-zsh-hook preexec check_ssh

env-pyenv(){
  # make sure pyenv is installed (brew install pyenv)
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
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

