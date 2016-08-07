function x
	git diff --ignore-space-at-eol -b -w --ignore-blank-lines .
	git status -s .
end
