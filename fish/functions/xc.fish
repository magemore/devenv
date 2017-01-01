function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m (string join ' ' $argv)
        timep git commit (string join ' ' $argv)
    else
        set STA (git status -s .)
        if test (count $STA) -gt 0;
            timep (pwd) git commit (string join '; ' $STA)
            git commit -m 'fix'
        end
    end
    date
    git push origin ^/dev/null >/dev/null &
end
