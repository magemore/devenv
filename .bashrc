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
   b=$(php -r "$p")
   echo $b
   #eval $b
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

edit_bashrc_source_after_and_push_to_github() {
  PWD=$(pwd)
  xgit
  cd ~/mage/devenv/
  vim ~/mage/devenv/.bashrc
  source ~/.bashrc
  git_commit_empty
  cd $PWD
  pwd
  ls
}
alias xr=edit_bashrc_source_after_and_push_to_github

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
