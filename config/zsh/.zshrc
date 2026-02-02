fortune | cowsay

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# shortcuts idk
bindkey -e
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
# End of lines configured by zsh-newuser-install

# environment variables
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export VISUAL="/usr/bin/env nvim"
export EDITOR="/usr/bin/env nvim"

export ANDROID_HOME=${HOME}/Android/Sdk
export PATH=${ANDROID_HOME}/tools:${PATH}
export PATH=${ANDROID_HOME}/emulator:${PATH}
export PATH=${ANDROID_HOME}/platform-tools:${PATH}
export PATH="$PATH:${HOME}/.local/bin"
export PATH=~/.cargo/bin:$PATH

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

# file shortcuts
alias bsp="cd ~/,config/bspwm && $EDITOR bspwmrc && exit"
alias bkm="cd ~/dotfiles/scripts/launchers && $EDITOR bookmarks.csv && exit"
alias dun="cd ~/.config/dunst && $EDITOR dunstrc && exit"
alias gam="cd ~/.config/gammastep && $EDITOR config.ini && exit"
alias hyp="cd ~/.config/hypr && $EDITOR hyprland.conf && exit"
alias kit="cd ~/.config/kitty && $EDITOR kitty.conf && exit"
# alias nxc="cd ~/.config/nixos && $EDITOR configuration.nix && exit"
alias nxc='tmux new-session -A -s nxc -c "$HOME/.config/nixos" \; split-window -h -p 36 -c "$HOME/.config/nixos" \; select-pane -L \; send-keys "$EDITOR" Enter'
alias pic="cd ~/.config/picom && $EDITOR picom.conf && exit"
alias pol="cd ~/.config/polybar && $EDITOR config.ini && exit"
alias rof="cd ~/.config/rofi && $EDITOR config.rasi && exit"
alias sxh="cd ~/.config/sxhkd && $EDITOR sxhkdrc && exit"
alias tmx="cd ~/.config/tmux && $EDITOR tmux.conf && exit"
alias way="cd ~/.config/waybar && $EDITOR config.jsonc && exit"
alias val="cd ~/obsidian-vault/ && $EDITOR && exit"
alias zat="cd ~/.config/zathura && $EDITOR zathurarc && exit"
alias zrc="$EDITOR ~/.zshrc && exit"

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
