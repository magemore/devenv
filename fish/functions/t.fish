function t
	if test (count $argv) -gt 0;
        task $argv;
    else
        task active
    end
end
