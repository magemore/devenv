function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m (string join ' ' $argv)
        timep (string join ' ' $argv)
    else
        set STA (git status -s .)
        timep (string join '; ' $STA)
    end
    git push origin ^/dev/null >/dev/null &
end

