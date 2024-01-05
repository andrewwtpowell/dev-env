set-option -g default-shell /bin/zsh

# Fix for neovim highlighting issue
set -g default-terminal "tmux-256color"
set-option -sa terminal-overrides ",xterm*:Tc"
