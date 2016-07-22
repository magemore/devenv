while read line
do
  php ~/mage/devenv/php/limit_line_length.php "$line"
done < "${1:-/dev/stdin}"

