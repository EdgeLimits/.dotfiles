#!/bin/bash

cd ~/.dotfiles
source .env

if ! pgrep -x "tmux" >/dev/null; then
  echo "Starting tmux server"
  tmux start-server
fi

SESSION_NAME="dotfiles"
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
  echo "Creating new session: $SESSION_NAME"

  tmux new-session -d -s $SESSION_NAME -n source
  tmux send-keys -t $SESSION_NAME "nvim ." C-m

  tmux new-window -t $SESSION_NAME -n shell

  if [[ "$DOTFILES_ENABLE_PERSONAL" == "True" ]]; then
    tmux new-window -t $SESSION_NAME -n personal-source
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:personal-source "cd personal" C-m
    tmux send-keys -t $SESSION_NAME:personal-source "nvim ." C-m

    tmux new-window -t $SESSION_NAME -n personal-shell
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:personal-shell "cd personal" C-m
  fi
  if [[ "$DOTFILES_ENABLE_WORK" == "True" ]]; then
    tmux new-window -t $SESSION_NAME -n work-source
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:work-source "cd work" C-m
    tmux send-keys -t $SESSION_NAME:work-source "nvim ." C-m

    tmux new-window -t $SESSION_NAME -n work-shell
    sleep 0.5
    tmux send-keys -t $SESSION_NAME:work-shell "cd work" C-m
  fi

  tmux select-window -t :1
fi

if [[ -z $TMUX ]]; then
  tmux attach-session -t $SESSION_NAME
else
  tmux switch-client -t $SESSION_NAME
fi

exit 0
