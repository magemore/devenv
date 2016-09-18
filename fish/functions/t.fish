function t
	if test (count $argv) -gt 0;
        task $argv;
    else
        clear;
        task active
    end
end
