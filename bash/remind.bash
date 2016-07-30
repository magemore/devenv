#todo: make mode variable alarm, task liist and execute some by mode
#todo: use termux tts api. but it doesn't work for some reason on my pc

# if it gets hard to write than make coffee script like parser/compiler into bash
cd ~/
say curent time $(date +%H:%M)
say $(php ~/since.php)
sleep 4
# instead of do while
# it will update file contents this way
~/mage/devenv/bash/remind.bash

