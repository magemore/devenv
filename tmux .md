You can write a small shell script that launches tmux with the required programs. I have the following in a shell script that I call dev-tmux. A dev environment:

#!/bin/sh 
tmux new-session -d 'vim'
tmux split-window -v 'ipython'
tmux split-window -h
tmux new-window 'mutt'
tmux -2 attach-session -d 
So everytime I want to launch my favorite dev environemnt I can just do

$ dev-tmux 
