function dstop
  sudo service apache2 stop
  bash -c 'docker stop $(docker ps -aq)'
end
