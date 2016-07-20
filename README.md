# devenv

how to use markdown
https://guides.github.com/features/mastering-markdown/

just my development environment scripts.
to make it easier to sync my dev scripts between devices

i use synergy and termux on my phone.

this github project will help me easier write shell scripts for my phone.

i use my twitter account as commands stream.
if there word reminder. php script on my phone will parse it and set android reminder.
it has flexible and custom reminder rules that i create on the go.

also manages todo list. kinda list that can be public.
it's as expirement how much information i can share to public.
what kind of todos i can share publicly.

i use task warrior for task list.
and inspired by time warrior i written my own smaller time tracking php script. that acts like app over termux bash on phone.
also when some text copied to buffer on my phone it reads contents of buffer with tts voice.
it's possible to use voice for reminders. and make reminders really smart and customizable to myself.
depending on context, current project, my location, time of the day, how well rested i am.

i use nootropics, modafinil, pramiracetam, phenlylpiracetam, caffeine etc.
different drugs changes my ways of thinking so reminders can adapt to it.
if i get hyper focused on modafinil reminder may act in different way.

sometimes i mix scripts and languages. for example bash script that generates php script that generates and executes bash script. it's a form of entertainment for me. i may have idea of writting my own language or using something else like coffee script that compiles into php code or executes php code right from coffee nodejs.
i played with it recently. but it was time waste. as a review of time spent i decided it was easier just to write it in php. but i like short expressions of coffee and it's hard to type properly lots of boilerplate code from phone.
unforunetly nodejs at the moment seems complicated to my because of it async nature. if i want to use node as bash with nice syntax. need to figure how to simplify async code with lots of nesting or defining lots of functions.
and if even testing code that i don't like functions to have definitions of params it accepts.
maybe write my language, processor based on coffee script that will work like php but generate async code with predefined attributes in callbacks. for the start it can be like in bash $1 $2 in function callback.
```

<%bash:alias:process_todo
echo do something related to processing
echo return done
%?>

so executing some system script may look like
  exec ls ->
    for $1 as d
      if todo in d than exec process_todo ->
        if $1 == done -> say ^

maybe don't use >. use or dont. so if > at the end of if condition line its possible to use just >
  or maybe if enter/new line than dont use > at all...
  
exec ls
  for $1 as f
    if todo in f
      exec process_todo
        if $1 == done -> say

f for file
d for dir
r for results

maybe make up some short symbol for exec
  @ls
  
@ls
  for $1 as f
    if todo in f
      @process_todo
        if $1 == done -> say
        
ls
  for ^ as f
    process_todo if todo in f
      if ^done ➜ say
      
ls
  for ^ as f
    process_todo if todo in f
      say if ^done
      
ls
  for ^ as f
    process_todo if todo in f
      say if done
      
ls
  for f
    process_todo if todo in f
      say if done
      
>check ls
  for f
    process_todo if todo in f
      say if done

now can execute something like
> if hour > 16 & < 20 ➜ check

➜ symbol can be placed instead of % in if condition
> if hour > 16 & < 20 % check

because i use % rarely -> long to type)
⤷ if hour > 16 & < 20 ➜ check

symbol > can be replaced with ⤷ so it just looks nicer and less confusion when read
it is replaced after save of file and different symbols have different replacements depending on context
i can make it so because i make it for myself to write and read so i don't have to care if someone else will read it

or even use system scripts when they not conflict with defined functions
  defined function will override system and @ will use something like @/bin/bash
    @bash
      if i have local function named bash
      
functions defined as
>hello hello world

params
>hello(say) ^  
will output first param
  idea conflicts with return without autput...
    so if function has ^ as output of $1 than also referenced by say
    and if it is called from other function
    >other hello hello world    
      hm) maybe dont use params
    
>say ^
# defined function named say that returns and outputs stdout first param

>other a = say
will not output return of say because it returned into var
>another say hello world

params in call separated with ,
if need to execute php function strpos

>some strpos data, ^
will search ^ inside data var and return 0...
so i replaced strpos with "in"
it acts as strpos!==FALSE
>some ^ in data

btw it's possible to define and redefine functions this way as i type
code starts with >
>function-name
will make function name
> function-name
will execute function name
<%
function-name
%>
is code block
so it maybe fun to write random ideas and write code inline with ideas and change code on the fly by redefining functions
for now when parser not implementet in may act just as pseudo code




say ^
  will use $1 to send data to my phone text to speech and $1 contains done
  for list as d similar to php foreach
  i may have lots of different for
  its a messy language with lots of constructs that duplicate each other
  if -> it may be same as if than. -> maybe also as function definition
  but if i feel like writting public function it will allow that
    and i can insert <%lang to include any other language.
      <%php foreach ($args as $d) system($d)  %>
        when language included preprocessor just creates new file with <% %> contents
          it maybe useful to use some specific libs to language
            it will have json returns for complex data
              it maybe useful to include bash
                <%bash:alias:xgit
                    if [[ -n $1 ]]; then
                      git add .; git commit -m "$1 $2 $3 $4 $5 $6 $7 $8"
                      return;
                    fi
                    clear
                    git diff .
                    git status .
                %>
              this code will generate permanent bash alias.
              <%=var%> maybe used to past code into generator of bash scripts/aliases as static
              or if <% %> executed inside bash it will make bash wrapper for my script language
              if <% %> included from bash than script in any language has access to bash $@ params
```

i like idea of attaching some machine learning or it maybe fun to attach human processing units.
amazon turk in order to help my scripts logic to act more like human. but this part seems complicated at the moment.
i will not write all at once. it's a side project and i write it just for fun. in any direction.
if i feel like i need something i just write it in 10 minutes or so.

termux enables me to write things from my phone offline anywhere.
reminders should sync and have offline phone mode.

code maybe random quality. it's just hacking things for fun of it and making somewhat smart pc that adapts to my activities. kinda my external mind that thinks on it's own and completes my mind. it's a vision of project a dream.
in real expect lots of messy or even stupid scripts if you bother to read.

- [ ] google chrome key shortcut quick go to pinned and back
- [ ] find a way to include code with comments maybe use markdown instead of making my own format
- [ ] so markdown by itself can include code blocks. but not nested code block. it's possible to solve if make named code block and referance them by name when including. it's easier to brainstorm code from inside one file but sometimes it's better if edit separate file. easier for navigation. make file path like name space to script /test/script.js and than markdown block for code. my parser will process markdown with such blocks and update code inside files from markdown and back. it's cool to code from mark down. can be messy to read for other but for myself its nice to generate.
- [ ] twitter message with todo creates updates github todo list in markdown in twitter.md it can contain todos and reminder states
- [ ] write some basic script in my lang and find ouy how to preprocess it. check sources of coffee script compiler
  - [ ] it will have implementation of 2 functions say and echo
  - [ ] echo just display text on screen
      - [ ] or use echo mode it will echo every line result
      - [ ] mode echo on
      - [ ] mode echo off
        - inside script
    - [ ] say will actually say with voice on my phone
    - [ ] redirect where to say with mode
      - [ ] my synergy devices laptops have their own speaker
      - [ ] if status report specific to laptop it can say on it's own
        - [ ] find out how to use text to speech on linux
          - on android it already works
- [ ] name my lang mage script? or just mage
