
function dyn-fzf
  if [ -n "$TMUX" ]
    fzf-tmux $argv
  else
    fzf $argv
  end
end

function fv
  dyn-fzf --query=$argv[1] | xargs nvim
end

function fbr
  git branch | dyn-fzf --query=$argv[1] | xargs git checkout
end

function crh
  set -l cols=3
  set -l sep='{{::}}'

  # Copy History DB to circumvent the lock
  # - See http://stackoverflow.com/questions/8936878 for the file path
  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h "select substr(title, 1, $cols), url from urls order by last_visit_time desc" | awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' | dyn-fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
end
