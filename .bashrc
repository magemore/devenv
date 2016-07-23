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



#alias mg=mgvg
#alias mag=mgvg

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

w_myspl(){
  watch -t -n 1 'echo "show processlist;" | mysql -uroot -pq1234e 2>/dev/null | grep local | grep -v processlist'
}
alias myspl=w_myspl
alias ucpu='ps aux | sort -rk 3,3 | head -5'
s_google(){
  links2 "https://google.co.uk/search?q=$1 $2 $3 $4 $5 $6 $7 $8"
}
s_firefox_google(){
  firefox "https://google.co.uk/search?q=$1 $2 $3 $4 $5 $6 $7 $8" 2>/dev/null >/dev/null &
}
s_go_google() {
  links2 -source "https://google.co.uk/search?q=$1 $2 $3 $4 $5 $6 $7 $8" > /tmp/s_go_google.html
  url=$(html_first_link)
  echo $url > /tmp/z_goo.txt
  echo '' > /tmp/z_s_go_tmp.html
  #links2 -source $url >> /tmp/z_s_go_tmp.html
  #links2 -dump $url >> /tmp/z_s_go_tmp_dump.txt
  phantomjs /home/a/tools/html_get/get.js $url > /tmp/z_s_go_tmp.html
  echo '<?php $s=file_get_contents("/tmp/z_s_go_tmp.html"); if (!$s) { file_put_contents("/tmp/z_s_go_tmp_result.html","not found"); return; } $a=explode("<h1",$s); if (isset($a[1])) { unset($a[0]); $s="<h1".implode("<h1",$a); } file_put_contents("/tmp/z_s_go_tmp_result.html",$s);' | php
  links2 -dump /tmp/z_s_go_tmp_result.html >> /tmp/z_goo.txt
  #links2 -dump $url >> /tmp/z_goo.txt
  vim /tmp/z_goo.txt
}
s_chrome_google(){
  google-chrome "https://google.co.uk/search?q=$1 $2 $3 $4 $5 $6 $7 $8" 2>/dev/null >/dev/null &
}
alias goo=s_google
alias go=s_go_google

alias R='R --no-save --slave'
alias foo=s_firefox_google
alias coo=s_chrome_google

calc_r() {
  #echo $1 $2 $3 $4 | R --no-save --slave | grep '\[' | gawk '{ print $2 }'
  echo $1 $2 $3 $4 | R --no-save --slave | gawk '{ print $2 }'

}
alias tl='tail -f'

alias nts='find ~/notes/ | xargs -d "\n" ag -l'
#alias xag='xargs -d "\n" ag -l'
alias xa='xargs -d "\n" '
alias xai='xargs -d "\n" -I{} '

notes_advanced_search() {
  if [[ -n $7 ]]; then ag -l $1  ~/notes/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6 | xargs -d "\n" ag -l $7; return; fi
  if [[ -n $6 ]]; then ag -l $1  ~/notes/| xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6; return; fi
  if [[ -n $5 ]]; then ag -l $1  ~/notes/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5; return; fi
  if [[ -n $4 ]]; then ag -l $1  ~/notes/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4; return; fi
  if [[ -n $3 ]]; then ag -l $1  ~/notes/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3; return; fi
  if [[ -n $2 ]]; then ag -l $1  ~/notes/ | xargs -d "\n" ag -l $2; return; fi
  if [[ -n $1 ]]; then ag -l $1  ~/notes/; return; fi
}
alias nt=notes_advanced_search

ev_notes_advanced_search() {
  if [[ -n $7 ]]; then ag -l $1  ~/evernote/text/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6 | xargs -d "\n" ag -l $7; return; fi
  if [[ -n $6 ]]; then ag -l $1  ~/evernote/text/| xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6; return; fi
  if [[ -n $5 ]]; then ag -l $1  ~/evernote/text/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5; return; fi
  if [[ -n $4 ]]; then ag -l $1  ~/evernote/text/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4; return; fi
  if [[ -n $3 ]]; then ag -l $1  ~/evernote/text/ | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3; return; fi
  if [[ -n $2 ]]; then ag -l $1  ~/evernote/text/ | xargs -d "\n" ag -l $2; return; fi
  if [[ -n $1 ]]; then ag -l $1  ~/evernote/text/; return; fi
}
alias ev=ev_notes_advanced_search

xargs_advanced_search() {
  if [[ -n $7 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6 | xargs -d "\n" ag -l $7; return; fi
  if [[ -n $6 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5 | xargs -d "\n" ag -l $6; return; fi
  if [[ -n $5 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4 | xargs -d "\n" ag -l $5; return; fi
  if [[ -n $4 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3 | xargs -d "\n" ag -l $4; return; fi
  if [[ -n $3 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2 | xargs -d "\n" ag -l $3; return; fi
  if [[ -n $2 ]]; then xargs -d "\n" ag -l $1 | xargs -d "\n" ag -l $2; return; fi
  if [[ -n $1 ]]; then xargs -d "\n" ag -l $1; return; fi
}
alias xag=xargs_advanced_search

findnn() {
  if [[ -n $2 ]]; then
    #echo $2;
    #echo $(pwd)
    #echo find $2 -type f -iname "*$1*";
    find $2 -type f -iname "*$1*";
    return; fi
  find . -type f -iname "*$1*"
}
alias fn=findnn
findnna() {
  if [[ -n $2 ]]; then
    #echo $2;
    #echo $(pwd)
    #echo find $2 -type f -iname "*$1*";
    find $2 -iname "*$1*";
    return;
  fi
  find . -iname "*$1*"
}
alias fna=findnna

xfind_multi() {
  if [[ -n $6 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | grep -i $6 | head -n 1 |  xargs -d "\n" ext_edit
    return;
  elif [[ -n $5 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | head -n 1 |  xargs -d "\n" ext_edit
    return;
  elif [[ -n $4 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | head -n 1 |  xargs -d "\n" ext_edit
    return;
  elif [[ -n $3 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | head -n 1 |  xargs -d "\n" ext_edit
    return;
  elif [[ -n $2 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | head -n 1 |  xargs -d "\n" ext_edit
    return;
  fi
  find . -type f | grep -i $1 | head -n 1 |  xargs -d "\n" ext_edit
}
alias fx=xfind_multi
alias xf=xfind_multi

f_f() {
  if [[ -n $6 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | grep -i $6
    return;
  elif [[ -n $5 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5
    return;
  elif [[ -n $4 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4
    return;
  elif [[ -n $3 ]]; then
    find . -type f | grep -i $1 | grep -i $2 | grep -i $3
    return;
  elif [[ -n $2 ]]; then
    find . -type f | grep -i $1 | grep -i $2
    return;
  fi
  find . -type f | grep -i $1
}
alias f='findm'

f_ffx() {
  if [[ -n $6 ]]; then
    FDR=$(find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | grep -i $6 | head -n 1)
    cd $FDR
    return;
  elif [[ -n $5 ]]; then
    FDR=$(find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | head -n 1)
    cd $FDR
    return;
  elif [[ -n $4 ]]; then
    FDR=$(find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | head -n 1)
    cd $FDR
    return;
  elif [[ -n $3 ]]; then
    FDR=$(find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | head -n 1)
    cd $FDR
    return;
  elif [[ -n $2 ]]; then
    FDR=$(find . -type d | grep -i $1 | grep -i $2 | head -n 1)
    cd $FDR
    return;
  fi
  FDR=$(find . -type d | grep -i $1 | head -n 1)
  cd $FDR
}
alias ffx=f_ffx
alias xff=f_ffx

f_ff() {
  if [[ -n $6 ]]; then
    find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5 | grep -i $6
    return;
  elif [[ -n $5 ]]; then
    find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4 | grep -i $5
    return;
  elif [[ -n $4 ]]; then
    find . -type d | grep -i $1 | grep -i $2 | grep -i $3 | grep -i $4
    return;
  elif [[ -n $3 ]]; then
    find . -type d | grep -i $1 | grep -i $2 | grep -i $3
    return;
  elif [[ -n $2 ]]; then
    find . -type d | grep -i $1 | grep -i $2
    return;
  fi
  find . -type d | grep -i $1
}
alias ff=f_ff

alias fn1='find .  -maxdepth 1 -iname "*$1*" 2>/dev/null'
alias fn1f='find . -type f  -maxdepth 1 -iname "*$1*" 2>/dev/null'
findnna2() {
  if [[ -n $2 ]]; then
    #echo $2;
    #echo $(pwd)
    #echo find $2 -type f -iname "*$1*";
    find $2 -maxdepth 2 -iname "*$1*" 2>/dev/null;
    return; fi
  find . -maxdepth 2 -iname "*$1*" 2>/dev/null
}
alias fn2=findnna2
findnna3() {
  if [[ -n $2 ]]; then
    #echo $2;
    #echo $(pwd)
    #echo find $2 -type f -iname "*$1*";
    find $2 -maxdepth 3 -iname "*$1*" 2>/dev/null;
    return; fi
  find . -maxdepth 3 -iname "*$1*" 2>/dev/null
}
alias fn3=findnna3

notesfindvim() {
  #find ~/notes/ -iname "*$1*" | cut -f 1 -d ' ' | xargs -n 1 vim
  find ~/notes/ -iname "*$1*" | cut -f 1 -d ' ' | xargs -n 1 echo
}
notesvim() {
  dirname ~/notes/$1 | xargs mkdir -p
  vim ~/notes/$1
}
alias nv=notesvim
alias nvv=notesfindvim
alias lol='~/tools/task/lol | less'

notes_mit() {
  MY_DATE=$(date +"%m/%d")

  mkdir -p $(dirname ~/notes/ztd/mit/${MY_DATE})
  # markdown
  vim ~/notes/ztd/mit/${MY_DATE}.md
}

alias mit=notes_mit

g_gac(){
  git add .; git commit -m "$1 $2 $3 $4 $5 $6 $7 $8"
}
g_gc(){
  git commit -m "$1 $2 $3 $4 $5 $6 $7 $8"
}


f_git_log_p(){
  if [[ -n $1 ]]; then
    git log -p $1 > /tmp/f_git_p
  else
    git log -p > /tmp/f_git_p
  fi
  /usr/bin/vim /tmp/f_git_p
}
alias glp=f_git_log_p

alias gl='git log --pretty=format:"%ad %ar  %h %s"'
alias gd='git log -p'
alias gac=g_gac
alias gacd='gitd add .; git commit -m "fix $(date)"'
alias ga='git add '
alias gc=g_gc
alias gst='git status'
alias gs='git status .'
alias gdf='git diff'
alias grm='git ls-files --deleted -z | xargs -0 git rm'
alias t='task'
alias ag='ag --follow'

open_atom_if_file_else_task_add() {
  # -e means
  if [ ! -e $1 ]; then
    echo something wrong
    #task add $@
    return
  fi
  # xdg may open not only atom files but all files associations
  rsy
  xdg-open $1 &>/dev/null &
}
alias a=open_atom_if_file_else_task_add
alias xclip='xclip -selection c'
alias fnn='find . -iname '
#alias gv='grep -iv'
#alias g='grep -i'
f_sr() {
  #php ~/play/compile/bash.php
  source ~/.bashrc
}
alias sr=f_sr
alias vr='vim ~/.bashrc; source ~/.bashrc'
alias vrr='vim ~/.vimrc'
f_br() {
  rsy
  ext_edit ~/.bashrc
}
alias br=f_br
f_brr() {
  rsy
  ext_edit ~/.vimrc
}
alias brr=f_brr
alias ll='ls -lhtra'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias deb='cd ~/mage/devenv/bin/'

alias wa='watch -t -n 1'
