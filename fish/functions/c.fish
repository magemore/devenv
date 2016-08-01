function ctest
  echo $argv
end


function c
  if begin; test (count $argv) -gt 0; and test -d $argv[1]; end
    if begin; test -d $argv[1]; end
      cd $argv[1]
    else
      ls -lhtra
    end
  else
    clear
  end
end
