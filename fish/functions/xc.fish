function xc
	git add .
git commit -m $argv
git push origin ^/dev/null >/dev/null
end
