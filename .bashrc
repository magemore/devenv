mge() {
  a='$a'
  ag='ag -l'
  xa='xargs -d "\n"'
  n='"\n"';
  p="$a=explode(' ','$@'); \
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
  p="$a=explode(' ','$@'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n; \
   echo ' | $xa ag $q'.implode('|',$a).'$q';"
   #echo $p
   b=$(php -r "$p")
  #echo $b
  eval $b
}

mgvg() {
  a='$a'
  ag='ag -l'
  xa='xargs -d "\n"'
  xai='xargs -d "\n" -I{}'
  dollar='$'
  n='"\n"';
  q="\'"
  wq='"'
  zero='0'
  p="$a=explode(' ','$@'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n; \
   echo ' | $xa grep ^ | ag '.implode(' | ag ',$a).' | ag $q'.implode('|',$a).'$q';"
   #echo $p
   #b=$(php -r "$p")
   echo $b
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
    git add .; git commit -m "$1 $2 $3 $4 $5 $6 $7 $8"
    git push origin
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

PATH=$PATH:/home/a/mage/devenv/bin


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

alias connect_to_android_just_ssh='ssh 192.168.0.201 -p 8022 -i ~/.ssh/android_rsa'
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
  echo $@ >> since.txt
}

add_wrap_taskwarrior() {
  $@ >> ~/.tasks_wrapper
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

source /data/data/com.termux/files/home/mage/devenv/.bashrc


say(){
    echo $(date)
    echo $@
    termux-clipboard-set $@
}

# reminder with delays in text to speech
# todo: use termux api for text to speech
# todo: use termux api for alarms and vibrate
remind(){
  ~/mage/devenv/bash/remind.bash $@
}

smart_count(){
    start_count $@
    say task started $@

}
