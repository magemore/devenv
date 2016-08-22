function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m (string join ' ' $argv)
        timep git commit (string join ' ' $argv)
    else
        set STA (git status -s .)
        if test (count $STA) -gt 0;
            timep git commit (pwd) (string join '; ' $STA)
            git commit -m (string join '; ' $STA)
        end
    end
    git push origin ^/dev/null >/dev/null &
end
