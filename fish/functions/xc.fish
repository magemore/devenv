function xc
    git add .
    if test (count $argv) -gt 0;
        git commit -m (string join ' ' $argv)    
    else
        git commit -m 'fix'
    end
    date
    git push origin
end
