function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m $argv
    else
        set STA (git status -s .)
        git commit -m (string join '; ' $STA)
    end
    git push origin ^/dev/null >/dev/null &
end

