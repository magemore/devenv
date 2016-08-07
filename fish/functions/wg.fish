function wg
	clear; file_get_contents http://twitter.win/alltext | g -C1 $argv
end
