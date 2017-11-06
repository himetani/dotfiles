peco-vivaldi-history() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    vivaldi_history="$HOME/Library/Application Support/Vivaldi/Default/History"
    open=open
  else
    #google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$vivaldi_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  %s\n", $1, $2}' | 
  peco  --prompt "[url]" | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null

}
zle -N peco-vivaldi-history
bindkey '^T' peco-vivaldi-history
