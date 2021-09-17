# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/smgr/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# OPENING DISPLAY #
## GAMES ##
if [ -x /usr/bin/cowsay -a -x /usr/bin/fortune -a -x /usr/bin/lolcat ]; then
  fortune -a | cowsay -f $(ls /usr/share/cows/ | shuf -n1) | lolcat
fi

echo '\n'

## WEATHER ##
#curl -s wttr.in/St+Louis| head -7 | tail -5

## VIM KEYS ##
bindkey -v
#bindkey "^[OA" up-line-or-search
#bindkey "^[OB" down-line-or-search
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

## TIMEWARRIOR ##
#export TIMEWARRIORDB=$HOME/Nextcloud/.timewarrior

export EDITOR='vim'

#export FZF_DEFAULT_OPTS="
#--color info:254,prompt:37,spinner:108,pointer:235,marker:235
#"
#--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254

## BAT ##
export BAT_THEME='Solarized (dark)'

## MEM CONFIG ##
#export MEM_DB_PATH='/home/smgr/Documents/data/mem/decks.sqlite'

## FIX GLOB ##
unsetopt nomatch

## RUST ##
#export PATH="$HOME/.cargo/bin:$PATH"

# convenient open
alias open="xdg-open"

# always run iPython in vim mode
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"

## fzf ##
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

### fzf asnd rga ###
rga-fzf() {
	RG_PREFIX="rga"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

## add local bin to path ##
export PATH="${PATH}:/home/smgr/.local/bin"

## firefox alias
alias firefox="firefox-developer-edition"

## pandoc latex building for now
md2pdf() {
  pandoc -N \
    --highlight-style tango \
    --template=/home/smgr/Documents/projects/templates/latex/pandoc/article_template.tex \
    --variable csquotes \
    --variable geometry="margin=1.3in" \
    --pdf-engine=xelatex \
    $1 \
    -o $2
}

mkhw() {
  pandoc \
    --highlight-style tango \
    --template=/home/smgr/Documents/projects/templates/latex/pandoc/hw_template.tex \
    --variable csquotes \
    --variable geometry="margin=1.0in" \
    --pdf-engine=xelatex \
    -t latex \
    $1 \
    -o ${1%.*}.pdf
}

#PATH="/home/smgr/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/smgr/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/smgr/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/smgr/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/smgr/perl5"; export PERL_MM_OPT;
