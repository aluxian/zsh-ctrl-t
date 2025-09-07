function ctrl-t-select() {
  if ! command -v fzf > /dev/null 2>&1; then
    echo "Error: fzf command not found."
  fi
  
  if [[ -f "package.json" ]]; then
    tasks=$(jq '.scripts|keys[]' -rc package.json)
  fi

  BUFFER=$(jq '.scripts|keys[]' -rc package.json | fzf --query "$LBUFFER")
  BUFFER="npm run ${BUFFER}"
  CURSOR=$#BUFFER
	
  zle redisplay
}

autoload -U ctrl-t-select
zle -N ctrl-t-select
bindkey '^t' ctrl-t-select
