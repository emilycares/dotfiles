kitty + complete setup fish | source

set fish_greeting

# alias npm="pnpm"

fish_add_path ~/tmp/bin

abbr tn "tmux new -s (pwd | sed 's/.*\///g')"

zoxide init fish | source
