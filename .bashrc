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
