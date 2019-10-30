function find_class
  ag 'class ' | grep '{' | grep php | grep -v '(' | grep -v '"'  | less
end
