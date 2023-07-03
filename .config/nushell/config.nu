def-env "c" [] {
  let path = (cat ~/Documents/folders.txt | fzf)

  cd $path
}

def "a" [action] {
  let command = (ari -a $action)
  nu -c $command
}
def "af" [action] {
  let command = (ari -f -a $action)
  nu -c $command
}
def "aset" [action] {
  let cmd = (history | get command | last)
  ari -a $action --set $cmd
}
