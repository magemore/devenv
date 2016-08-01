function import_bash_aliases --description 'bash aliases to .fish function files.'
    for a in (cat ~/.bashrc  | grep "^alias")
        set aname (echo $a | grep -Eoe "[a-z0-9]+=" | sed 's/=//')
        set command (echo $a | sed 's/^alias .*=//' \
          | sed 's/^ *\'//' | sed 's/\' *$//' )
        echo "Processing alias $aname as $command"
        if test -f ~/.config/fish/functions/$aname.fish
            echo Function $aname is already defined. Skipping...
        else
            alias $aname $command
            funcsave $aname
        end
    end
end
