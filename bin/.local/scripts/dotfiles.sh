#!/bin/bash

source .env

SESSION_NAME="dotfiles"
GITHUB_REPO="git@github.com:EdgeLimits/.dotfiles.git"
DIRECTORY="$HOME/.dotfiles"

PERSONAL_GITHUB_REPO="git@github.com:EdgeLimits/.dotfiles-personal.git"
PERSONAL_DIRECTORY="$HOME/.dotfiles-personal"

WORK_GITHUB_REPO="git@github.com:EdgeLimits/.dotfiles-work.git"
WORK_DIRECTORY="$HOME/.dotfiles-work"

UPDATE_FLAG=0
if [[ " $@ " == *" --update "* ]]; then
  UPDATE_FLAG=1
fi

if [ ! -d "$DIRECTORY" ]; then
  git clone $GITHUB_REPO "$DIRECTORY"
fi

if [[ "$DOTFILES_ENABLE_PERSONAL" == "True" ]] && [ ! -d "$PERSONAL_DIRECTORY" ]; then
  git clone $PERSONAL_GITHUB_REPO "$PERSONAL_DIRECTORY"
fi

if [[ "$DOTFILES_ENABLE_WORK" == "True" ]] && [ ! -d "$WORK_DIRECTORY" ]; then
  git clone $WORK_GITHUB_REPO "$WORK_DIRECTORY"
fi

if ! pgrep -x "tmux" >/dev/null; then
  echo "Starting tmux server"
  tmux start-server
fi

if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
  echo "Creating new session: $SESSION_NAME"

  tmux new-session -d -s $SESSION_NAME -n source
  tmux send-keys -t $SESSION_NAME "cd $DIRECTORY" C-m
  tmux send-keys -t $SESSION_NAME "nvim ." C-m

  tmux new-window -t $SESSION_NAME -n shell

  if [[ "$DOTFILES_ENABLE_PERSONAL" == "True" ]]; then
    tmux new-window -t $SESSION_NAME -n personal-source
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:personal-source "cd $PERSONAL_DIRECTORY" C-m
    tmux send-keys -t $SESSION_NAME:personal-source "nvim ." C-m

    tmux new-window -t $SESSION_NAME -n personal-shell
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:personal-shell "cd $PERSONAL_DIRECTORY && clear" C-m
  fi
  if [[ "$DOTFILES_ENABLE_WORK" == "True" ]]; then
    tmux new-window -t $SESSION_NAME -n work-source
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:work-source "cd $WORK_DIRECTORY" C-m
    tmux send-keys -t $SESSION_NAME:work-source "nvim ." C-m

    tmux new-window -t $SESSION_NAME -n work-shell
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:work-shell "cd $WORK_DIRECTORY && clear" C-m
  fi

fi

if [[ "$UPDATE_FLAG" == "1" ]]; then
  tmux send-keys -t $SESSION_NAME:shell "git pull && git submodule update --remote --merge" C-m

  if [[ "$DOTFILES_ENABLE_PERSONAL" == "True" ]]; then
    tmux send-keys -t $SESSION_NAME:personal-shell "git pull" C-m
  fi

  if [[ "$DOTFILES_ENABLE_WORK" == "True" ]]; then
    tmux send-keys -t $SESSION_NAME:work-shell "git pull" C-m
  fi
fi

if [[ -z $TMUX ]]; then
  tmux attach-session -t $SESSION_NAME
  tmux select-window -t :1
else
  tmux switch-client -t $SESSION_NAME
fi

exit 0
