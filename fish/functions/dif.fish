function dif
	if test (count $argv) -gt 0;
  	git diff --ignore-space-at-eol -b -w --ignore-blank-lines $argv
  else
    git diff .
  end
end
