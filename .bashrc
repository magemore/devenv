mge() {
  a='$a'
  ag='grep -ril '
  xa='xargs -d "\n"'
  n='"\n"';
  p="$a=explode(' ','"$@"'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n;"
  b=$(php -r "$p")
  eval $b
}
#sr; mge include x11 window manag | xai ag 'window' {} | g click | ag 'click|window'

mgv() {
  a='$a'
  ag='ag -l'
  xa='xargs -d "\n"'
  n='"\n"';
  q="\'"
  p="$a=explode(' ','"$@"'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n; \
   echo ' | $xa ag $q'.implode('|',$a).'$q';"
   #echo $p
   b=$(php -r "$p")
  #echo $b
  eval $b
}

mgvg() {
  a='$a'
  #ag='grep -rli '
  ag='ag -l  '
  xa='xargs -d "\n"'
  xai='xargs -d "\n" -I{}'
  dollar='$'
  n='"\n"';
  q="\'"
  wq='"'
  zero='0'
  p="$a=explode(' ','"$@"'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n; \
   echo ' | grep -v css | $xa grep ^ |  ~/mage/devenv/php/cut_line.bash | ag '.implode(' | ag ',$a).' | ag $q'.implode('|',$a).'$q';"
   #echo $p
   b=$(php -r "$p")
   #echo $b
   eval $b
}


alias mg=mgvg
alias mag=mgvg

tar_improved() {
  tar czvf $1.tgz $1
}
alias trc=tar_improved
alias du='du -hs * | less'
alias rm='rm -r'
alias apt='apt-get'
cd_devenv() {
    cd ~/mage/devenv/
    xgit
    ls
}
alias de=cd_devenv


xgit() {
  if [[ -n $1 ]]; then
    git add .; git commit -m "$@"
    git push origin 2>/dev/null
    return;
  fi
  clear
  git diff .
  git status .
  git pull 2>/dev/null
}
alias x=xgit

git_commit_empty() {
  git add .; git commit -m 'xc'
  #git push origin &>/dev/null
  git push origin
  return;
}
alias xc=git_commit_empty
# acts like watch a bit
loop_git_commit_empty() {
  while true; do
    git_commit_empty
    sleep 30
  done

}
alias wxc=loop_git_commit_empty
alias ln='ln -s '

edit_bashrc_sublime() {
  rsy
  ext_edit ~/mage/devenv/.bashrc
}
alias bxr=edit_bashrc_sublime

edit_vimrc_sublime() {
  rsy
  ext_edit ~/mage/devenv/.vimrc
}
alias bxrr=edit_vimrc_sublime

edit_bashrc_source_after_and_push_to_github() {
  PWD=$(pwd)
  xgit
  git_commit_empty
  cd ~/mage/devenv/
  vim ~/mage/devenv/.bashrc
  source ~/.bashrc
  git_commit_empty
  cd $PWD
  pwd
  ls
}
alias xr=edit_bashrc_source_after_and_push_to_github

edit_vimrc_and_push_to_github() {
  PWD=$(pwd)
  xgit
  git_commit_empty
  cd ~/mage/devenv/
  vim ~/mage/devenv/.vimrc
  git_commit_empty
  cd $PWD
  pwd
  ls
}
alias xrr=edit_vimrc_and_push_to_github

f_bashn() {
  rsy
  if [ ! -f "/home/a/play/bin/$1" ]; then
    cp "/home/a/play/bin/proto" "/home/a/play/bin/$1"
    chmod a+x "/home/a/play/bin/$1"
  fi
  ext_edit "/home/a/play/bin/$1"
}
alias bnn=f_bashn


dir_resolve()
{
  cd "$1" 2>/dev/null || return $?  # cd to desired directory; if fail, quell any error messages but return exit status
  echo "`pwd -P`" # output full, link-resolved path
}

# example uses for to list 2 folders
# export PATH=/opt/bin:/usr/local/bin:/usr/contrib/bin:/bin:/usr/bin:/usr/sbin:/usr/bin/X11
# # add optional items to the path
# for bindir in $HOME/local/bin $HOME/bin; do
#     if [ -d $bindir ]; then
#         PATH=$PATH:${bindir}
#     fi
# done


# echo $PATH | tr -s / | sed 's/\/:/:/g;s/:/\n/g'
# Now suppose $d contains the directory you want to check. Then pipe the previous command to check $d in $PATH.

# echo $PATH | tr -s / | sed 's/\/:/:/g;s/:/\n/g' | grep -q "^$d$" || echo "missing $d"


# echo $PATH | tr -s / | sed 's/\/:/:/g;s/:/\n/g'

new=~/mage/devenv/bin
case ":${PATH:=$new}:" in
    *:$new:*)  ;;
    *) PATH="$new:$PATH"  ;;
esac

#export PATH="$PATH:~/mage/devenv/bin"

#echo $PATH | grep /my/bin >/dev/null || PATH=$PATH:/my/bin
#note that the grep pattern is overly broad. Consider using egrep -q "(^|:)/my/bin(:|\$)" instead of grep /my/bin >/dev/null.

#printf '%s' ":${PATH}:" | grep -Fq ":${my_path}:"
# if ! printf '%s' ":${PATH-}:" | grep -Fq ":${my_path-}:"
# then
#     PATH="${PATH-}:${my_path-}"
# fi

open_php_editor_for_bash_script() {
  rsy
  if [ ! -f "/home/a/play/bin/$1" ]; then
    echo "/home/a/play/php/bash_prototype.php" > "/home/a/bin/$1"
    chmod a+x "/home/a/bin/$1"
  fi
  #touch "/home/a/play/coffee/$1.c" 2>/dev/null
  ext_edit "/home/a/bin/$1.php"
}
alias pb=open_php_editor_for_bash_script

connect_to_android_mosh() {
  mosh -ssh='ssh -p 8022 -i ~/.ssh/android_rsa' 192.168.0.201
}
alias an=connect_to_android_mosh


compile_coffe_and_run_nodejs() {
  # coffee script
  # syntax is nice to play. i like editing and improving code with it.
  # can do same thing just with php i guess
  cs "$@"
}
alias n=compile_coffe_and_run_nodejs

watch_nodejs_coffee() {
  watch -t cs $1
}
alias wn=watch_nodejs_coffee


f_npm_install() {
  PWD=$(pwd)
  cd /home/a/play/coffee
  npm install $1
  cd $PWD
}
alias ni=f_npm_install




open_nodejs_coffee_editor_or_create_new() {
  rsy
  if [ ! -f "/home/a/play/coffee/$1.coffee" ]; then
    cp "/home/a/play/coffee/proto.coffee" "/home/a/play/coffee/$1.coffee"
  fi
  #touch "/home/a/play/coffee/$1.c" 2>/dev/null
  ext_edit "/home/a/play/coffee/$1.coffee"
}
alias nb=open_nodejs_coffee_editor_or_create_new

open_nodejs_coffee_editor_compiled_js_after_coffee() {
  rsy
  ext_edit "/home/a/play/coffee/$1.js"
}
alias nbj=open_nodejs_coffee_editor_compiled_js_after_coffee
alias ta='task limit:page=1000'
alias tacalltab='task limit:page=1000 calltab'
alias h1=' head -n 1'
alias pw='cd ~/play/timep'

# idea write tool to find files save found results to favorites track opened files by vim and other editors
# so find files will give interactive list where possible to switch between files by pressing 1, 2, 3 or arrows
# if it is a dearictory quick switch and show contents of dir

start_count() {
  #home
  cd;
  date +%H:%M > since.txt
  echo "$@" >> since.txt
}

add_wrap_taskwarrior() {
  "$@" >> ~/.tasks_wrapper
}

list_wrap_taskwarrior() {
  CMD='cat ~/.tasks_wrapper';
  for var in "$@"
  do
    CMD+=$CMD"| grep $var"
  done
}

# dont source from here make .bashrc.phone file that will source code deisgnated only for phone
#alias a=idea_add_taskwarrior_like

alias ww='watch -t -n 1'
alias wp='watch -t -n 1 php '

#source /data/data/com.termux/files/home/mage/devenv/.bashrc


say(){
    echo $(date)
    echo "$@"
    termux-clipboard-set "$@"
}

# reminder with delays in text to speech
# todo: use termux api for text to speech
# todo: use termux api for alarms and vibrate
remind(){
  ~/mage/devenv/bash/remind.bash "$@"
}

add_task_devenv() {
  echo '- [ ] '"$@" >> ~/mage/devenv/auto.tasks.md
}

smart_count(){
  if [[ -n $1 ]]; then
    MSG="$@"
  else
    # make fallback for termux on pc
    MSG=$(termux-dialog)
  fi
  start_count $MSG
  say task started $MSG
  add_wrap_taskwarrior $MSG
  add_task_devenv $MSG
  cd ~/mage/devenv/
  xgit $MSG
  ls -lhtra | tail
  cat ~/mage/devenv/auto.tasks.md | tail
}


mkdir_cd() {
  mkdir -p $1
  cd $1
}
alias md=mkdir_cd
alias m='mkdir'
alias rcp='rsync -aP'
alias tio='cd /srv/misc/time.io'
alias tl='cd ~/tools/'
alias tlc='cd ~/tools/cron/'
alias ww='watch -t -n 1'
alias wp='watch -t -n 1 php '

textled() {
  textl $1;
  /usr/bin/vim $1;
}
alias v=textled
alias vi=textled
alias vim=textled
alias sx='get_xclip | xclip'
alias e='cd /srv/esf/'
alias ea='cd /srv/esf/system/application'
alias ew='cd /srv/esf/sites/esfwholesalefurniture.com'

alias node='nodejs'
alias nj='nodejs'
# alias n='nodejs'

alias cl='clear'
alias cle='clear'
alias clea='clear'
f_p() {
  if [ ! -f $1 ]; then
    php "/home/a/play/php/$1.php"
    return
  fi
  if [[ -n $1 ]]; then
    php $1
    return
  fi
  pwd
}
alias p=f_p

#alias h='cd ~/; date; pwd;'
# c = cd does the sameif just empty


#alias x='clear; git status .'


# example xclip image. todo: make it after print screen pressed and file sorted
# $ xclip -selection clipboard -t image/png -o > /tmp/avatar.png
# $ see /tmp/avatar.png  # yep, that's it

alias vgi='vim .gitignore'
alias cc='cd ..'
cdandclear() {
  if [[ -n $1 ]]; then
    if [ ! -d "$1" ]; then
      xfind_multi $@
      return
    fi
    cd $1;
    pwd
    ls
    return;
  fi
  clear
#  date
}
alias c=cdandclear
alias ch='cd'
alias hi=history
f_haml(){
  #haml $1 > $2
  vim /home/a/play/haml/t.h
  haml /home/a/play/haml/t.h > /tmp/share
}
alias h=f_haml
# todo make alias to quick open last editee vim file wzcept some

alias srv='cd /srv/'
alias srm='cd /srv/misc/'
alias srb='cd /srv/misc/bootstrap/'
alias mage='cd /srv/magento'
alias book='cd /home/a/play/bookshots'


silent_findnn() {
  if [[ -n $2 ]]; then
    find $2 -type f -iname "*$1*" 2> "/home/a/find/err/$1" > "/home/a/find/$1" &
    return; fi
  find . -type f -iname "*$1*" 2> "/home/a/find/err/$1" > "/home/a/find/$1" &
}
alias sfn=silent_findnn
alias fns=silent_findnn
alias gcron='vim /usr/bin/git_all'
alias cp='cp -rf'
alias sm='cd /srv/magento'
alias xasa='xargs -d "\n" sublime_text'
alias xas='head -n 1 |  xargs -d "\n" ext_edit'


f_mdnf() {
  PWD=$(pwd)
  s='/'
  F=$(echo $PWD$s$1)
  D=$(dirname $F)
  mkdir -p $D
}

git_commit_empty() {
  git add .; git commit -m 'xc'
  git push origin &>/dev/null
  #git push origin
  return;
}
alias xc=git_commit_empty

# find out what ed isand why it freeze my bash
alias ed='de'

search_files() {
  php ~/mage/devenv/php/search_files.php
}
f_timep() {
  /home/a/play/timep/timep $*
  /home/a/play/timep/timep log | tail -n5
}
alias w=f_timep
alias wl='/home/a/play/timep/timep log | tail -n5'
alias q='watch -n 1 -t timep'
alias r='/home/a/play/timep/task_rules'
alias vic='cat'
alias psg='ps -A | grep -i 'lias psg='ps -A | grep -i '


# todo: write something for sed
# fn php | xai sed -i -e 's/catalog_show_collectiont/catalog_show_collection/g' {}



# cryptic names don't remember. make bash functions bigger
# this one creates directory for file to edit
make_dir_p_and_open_file_with_external_editor() {
  rsy
  f_mdnf $1
  touch $1
  ext_edit $1
}
alias fb=make_dir_p_and_open_file_with_external_editor


open_file_with_external_editor_focus_on_pc() {
  rsy
  export DISPLAY=:0
  sublime_text $@ 2> /dev/null
  #ext_edit $1
  #xdg-open $1
}
alias b=open_file_with_external_editor_focus_on_pc


find_and_grep_result() {
  find . -type f -iname "*$1*" | grep -i $1
}
alias fng=find_and_grep_result


alias cx='chmod a+x'
touch_chmod() {
  touch $1
  chmod a+x $1
}
alias tx=$1

alias s='/home/a/play/timep/taskw_start'
alias pl='cd /home/a/play/'
alias mplay='mplayer -shuffle -playlist /home/a/Music/playlist.txt'

alias u='sort | uniq'
alias smartgit='/home/a/apps/smartgit/bin/smartgit.sh &'

alias gawk1='gawk '"'"'{ print $1 }'"'"''
alias gawk2='gawk '"'"'{ print $2 }'"'"''
alias gawk3='gawk '"'"'{ print $3 }'"'"''
alias gawk4='gawk '"'"'{ print $4 }'"'"''
