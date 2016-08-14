function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m $argv
    else
        git commit -m 'no comment'
    end
    git push origin ^/dev/null >/dev/null &
end
