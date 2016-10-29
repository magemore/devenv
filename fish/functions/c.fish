function c
  if begin; test (count $argv) -gt 0; end
    if begin; test -d $argv[1]; end
      cd $argv[1]
    else
      ls -lhtra | grep -i $argv[1]
    end
  else
    clear
  end
end
