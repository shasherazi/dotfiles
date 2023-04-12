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
unsetopt beep
setopt HIST_SAVE_NO_DUPS
setopt AUTO_LIST
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
bindkey -e
# End of lines configured by zsh-newuser-install


# aliases
alias ..="cd .."
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vim="nvim"
alias lf="lfub"

# file shortcuts
alias bsp="nvim ~/.config/bspwm/bspwmrc"
alias dots="nvim ~/dotfiles/"
alias dun="nvim ~/.config/dunst/dunstrc"
alias kit="nvim ~/.config/kitty/kitty.conf"
alias pic="nvim ~/.config/picom/picom.conf"
alias pol="nvim ~/.config/polybar/config.ini"
alias rof="nvim ~/.config/rofi/config.rasi"
alias sxh="nvim ~/.config/sxhkd/sxhkdrc"
alias zat="nvim ~/.config/zathura/zathurarc"
alias zshconfig="nivm ~/.zshrc"

# environment variables
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export PATH="$PATH:/home/shasherazi/.local/share/gem/ruby/3.0.0/bin:/home/shasherazi/.local/bin"
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
# export CM_SELECTIONS="clipboard" # monitor only "clipboard" clipboard for clipmenud
# export _JAVA_AWT_WM_NONREPARENTING=1 # makes jetbrains IDEs work


# plugins
source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh_plugins/sudo-plugin/sudo.plugin.zsh
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
