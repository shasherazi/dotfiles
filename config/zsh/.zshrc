# startup ascii
STARTUP_IMAGE="$HOME/dotfiles/assets/startup/images/kanagawa.png"
GAP=5
kitten icat --clear --place 20x20@3x1 --align left "$STARTUP_IMAGE"

for i in {1..$GAP}; do
  echo "\n"
done
# echo "
#     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠶⠞⠛⠛⠉⠉⠉⠉⠉⠙⠛⢦⠀⠀⠀⠀
#     ⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠞⠉⠀⠀⠀⠆⠀⠀⠀⠀⠀⠀⠀⠀⠐⢹⠀⠀⠀
#     ⠀⠀⠀⠀⠀⠀⢠⡾⠋⠀⠀⠀⠀⢀⣀⣤⣤⠴⠶⠶⠶⠶⠶⡶⡾⠀⠀⠀⠀
#     ⠀⠀⠀⠀⠀⣴⠋⠀⠀⢀⡴⠾⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⠀
#     ⠀⠀⠀⢀⡼⠁⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠃⠀⠀You forgot something...
#     ⠀⠀⢀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀
#     ⠀⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀
#     ⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀
#     ⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⣰⣏🧠⣀⣀
#     ⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣆⠀⠀⠀⠀⠀⠀⢸⡇⣠⠏⠉⠛⠛⠋⠁
#     ⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠀⠀⠀⠀⠀⢸⣿⠋⠀⠀⠀⠀⠀⠀
#     ⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⣼⡇⠀⠀⠀⠀⠀⠀⠀
#     ⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⣼⠃⣧⠀⠀⠀⠀⠀⠀⠀
# "

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# shortcuts idk
bindkey "^[[3~" delete-char

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
unsetopt beep
setopt HIST_SAVE_NO_DUPS
setopt AUTO_LIST
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
bindkey -e
# End of lines configured by zsh-newuser-install

# environment variables
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"

export ANDROID_HOME=${HOME}/Android/Sdk
export PATH=${ANDROID_HOME}/tools:${PATH}
export PATH=${ANDROID_HOME}/emulator:${PATH}
export PATH=${ANDROID_HOME}/platform-tools:${PATH}
export PATH="$PATH:/home/shasherazi/.local/bin"
export PATH="$PATH:/home/shasherazi/.local/share/gem/ruby/3.3.0/bin"
export PATH="$PATH:/home/shasherazi/.dotnet/tools"
export PATH=~/.cargo/bin:$PATH
export PATH=~/.npm-global/bin:$PATH

export npm_config_prefix="$HOME/.local"
# export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
export $(dbus-launch)
# export CM_SELECTIONS="clipboard" # monitor only "clipboard" clipboard for clipmenud
export _JAVA_AWT_WM_NONREPARENTING=1 # makes jetbrains IDEs work
export GPG_TTY=$(tty)

# aliases
alias ..="cd .."
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vim="$EDITOR"
alias nvim="$EDITOR"
alias lf="lfub"

# file shortcuts
alias bsp="$EDITOR ~/.config/bspwm/bspwmrc && exit"
alias bkm="$EDITOR ~/dotfiles/scripts/launchers/bookmarks.csv && exit"
alias dots="$EDITOR ~/dotfiles/ && exit"
alias dun="$EDITOR ~/.config/dunst/dunstrc && exit"
alias gam="$EDITOR ~/.config/gammastep/config.ini && exit"
alias hyp="$EDITOR ~/.config/hypr/hyprland.conf && exit"
alias kit="$EDITOR ~/.config/kitty/kitty.conf && exit"
alias pic="$EDITOR ~/.config/picom/picom.conf && exit"
alias pol="$EDITOR ~/.config/polybar/config.ini && exit"
alias rof="$EDITOR ~/.config/rofi/config.rasi && exit"
alias sxh="$EDITOR ~/.config/sxhkd/sxhkdrc && exit"
alias tmx="$EDITOR ~/.config/tmux/tmux.conf && exit"
alias way="$EDITOR ~/.config/waybar/config.jsonc && exit"
alias zat="$EDITOR ~/.config/zathura/zathurarc && exit"
alias zrc="$EDITOR ~/.zshrc && exit"

# tmux
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux new-session -A -s main
# fi

# plugins
source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh_plugins/sudo-plugin/sudo.plugin.zsh
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
