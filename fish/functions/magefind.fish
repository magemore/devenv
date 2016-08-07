function magefind
  find /srv/mage2/ | grep -i $argv | head -n1
end
