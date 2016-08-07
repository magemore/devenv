function tmux_pane_title --on-variable PWD
      printf "\033k$PWD\033\\"
end
