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

↯function_name = ">function_name"
⤷ code = "> code"

" in quotes first symbol means start of the line

↯check ls
  for f
    process_todo if todo in f
      say if done
⤷if hour > 16 & < 20 ➜ check↯

"⤷if hour > 16 & < 20 ➜ check↯"="> if hour > 16 & < 20 -> check"
↯ added after save at the function call just to read easier and as confirmation that parser sees it as function not a variable or text

text can be type in 'text' or as just text
if there variable text it will use var if not var than as text
for variable it can use symbol to mark it as var but you don't have to type this symbol ⟳

↯check ⇶ls
  for ⟳f
    ⇶process_todo if todo in ⟳f
      say if done
⤷if ⟳hour > 16 & < 20 ➜ check↯

⟳hour is built in var that returns current ⟳hour
also ⟳ny-hour returns current hour in ny

bash and system apps marked as ⇶

async code
  ↯setInterval 500
    ↯check
    
i havent decided yet in what language to compile it
maybe into coffee script or javascript better will be less confusion...
hard choice. it can also use php functions as native

file-get
file-save
file-set

file-save=file-set

as for php file_get_contents its much easier to type

file-get /tmp/share
than
echo file_get_contents('/tmp/share');

file-set ⟳hour
it remembers last file opened with file-get in same context
or
file-set /tmp/share, ⟳hour

also code maybe in nodejs compiled into coffee script with lots of () to be sure it compiles right
and uses node module to execute php functions async than write native alternatives for often used functions
nodejs executes no problem on my mobile phone

need to figure how to make promises i like how it's implemented in type script
also code maybe compiled even into rust ) if speed is critical. it maybe fun to write compilers for languages
just need to implement basic things like exec system, parse return of system exec and include in native vars
maybe use something like DNode and make code execution shared between my devices.
so in this way scripts from phone maybe executed on pc when it's enabled in order to speed it up.
conflicts only in file system that needs to be synced. possible to use hadoop... but it's too slow.
so something like rsync with md5 checks can do. but hard to sync fast changes. too complicated.
possible to use remote exec for things that not change current state of device file system
so for example it's possible to call compiler of script on pc if its turned on else compile on local.
for example

maybe use - symbols instead of ^ no need to press shift)

file-get test.sass
  *sass - test.sass
    file-set -

or just
*sass test.sass
it will get local test.sass send it to pc and there it will execute and save on local
local means phone

it's possible to set device by command and than everything will be executed on pc and jsut execute sync that will rsync resulted files on device from where it was called

device pc
sass test.sass
sync

it can be sync by schedule anyway. calling it will speed up sync and possible make async call after it

device pc
mode async
sass test.sass
sync

in a way like js async

setTimeout(function() {
  console.log('done1');
  setTimeout(function() {  
    console.log('done2');
  },10);
},10);

so if mode async

mode async
setTimeout 10
console.log done1
setTimeout 10
console.log done2

so this way easier to type than to hit enter each time and possible execute async code written as regular bash scripts
figure how to implement pipes... they are at the moment return of pipe is inside - or ^ var witch is the same as $1
if $1 not set as param if. so ^ can equal to $1 if no pipe
it check at the end of piped stdin for return done, etc and if it finds return done at the end stdin it places ^=done

so
mode async, bash, pipe
find . -name *.txt
grep foo
grep bar
grep -v buzz
mode sync
cd 1; ls

it equals to bash
find . -name *.txt | grep foo | grep bar | grep -v buzz; cd 1; ls

it also possible to write in mode async
mode bash. async
find . -name *.txt; grep foo; grep bar; grep -v buzz;
cd 1; ls

and mixing with php
mode async, bash, php, pipe
file-get list.txt
explode \n
for
trim
chown a:a

also for can automatically explode just as example of use of php code
file-get list.txt
for
trim
chown a:a

i liked assembler for it's simplicity and registers


mode novars
file-get list.txt for is_file proc
>proc file-get for trim

it will get contents of files and trim every line
if emmited when function names started with is and it uses registers as variable replacement

find .
grep foo
file-get for is_file file-get trim

maybe make it as bash alternative simple to find and change files
just time and it executes
define functon with
>function
and it replaces old definition
it has git history of all definitions
if need to use xargs near command than just enter x before command name

i have such bash script to search files contents rewrite it mage script

mgvg() {
  a='$a'
  ag='ag -l'
  xa='xargs -d "\n"'
  xai='xargs -d "\n" -I{}'
  dollar='$'
  n='"\n"';
  q="\'"
  wq='"'
  zero='0'
  p="$a=explode(' ','$@'); \
   echo '$ag '.implode(' | $xa $ag ',$a).$n; \
   echo ' | $xa grep ^ | ag '.implode(' | ag ',$a).' | ag $q'.implode('|',$a).'$q';"
   #echo $p
   b=$(php -r "$p")
  # echo $b
   eval $b
}

mgvg foo bar buzz
produces
ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz | xargs -d "\n" grep ^ | ag foo | ag bar | ag buzz | ag 'foo|bar|buzz'


it implodes $@ in a way to make it as bash command
>mgvg
# first implode with xargs -d "\n" ag -l
# $@ places in register
# maybe make command map instead of implode explode if map than $@ can be treated as array
keys=$@
explode
implode xargs -d "\n" ag -l
`ag -l+^
cmd=

# it was line by line because it wasnt inside loop, empty line marks end of loop
# cmd= creates variable cmd and places content of register there
# ` symbols marks end of bash line so it will not execute ag -l and just contact 2 strings
# plus symbol rare inside my bash scripts so it mean contact line and end of line
# ` because there system command ag and to be sure it is text
for keys
cmd+=`ag+^
==============
==== maybe better use $ instead of ^ and ^ may contain register that pushed after main $ overwritten

>mgvg
# \ = | easier to type
symbol \=|
keys=$@
implode `xargs -d "\n" ag -l \
cmd=`ag -l+$
# ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz |

for keys
cmd+=`ag+$+\
# ag foo | ag bar | ag buzz

cmd+=`xargs -d "\n" grep ^

# there space than close string
# if use ' for strings it will make it harder to escape for bash scripts
cmd+=`ag `
implode \, keys
cmd+=$
# ag 'foo|bar|buzz'

exec cmd


----
it equals to php code
<?php
$r = $keys = $argv;
$r = implode("xargs -d "\n" ag -l |",$r);
$r = $cmd = 'ag -l'+$r;
# ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz |

foreach ($keys as $r) {
  # no $r in loops
  # if it was for keys as key than it could be possible to use $r
  # instead call function or maybe implement second register
  # $r2 = $cmd+='ag'+$r+'|';
  $cmd+='ag'+$r+'|';
}
# ag foo | ag bar | ag buzz

$cmd+='xargs -d "\n" grep ^';

# maybe make some smart parser that checks if register used in block and if not it will make cleaner php
$r = $cmd+='ag ';
$r = implode(' ', $keys);
$r = $cmd+=$r;
# ag 'foo|bar|buzz'

$o=[];
exec($cmd,$o);


http://askubuntu.com/questions/98782/how-to-run-an-alias-in-a-shell-script
In bash 4 you can use special variable: $BASH_ALIASES.
>>
and wrap aliases calls
maybe make exec like 
it will allow to define my script as bash alias and use bash aliases inside
file-set /tmp/cmd-rand-id
$o=[];
exec('bash /tmp/cmd-rand-id',$o);

<<
For example:
$ alias foo="echo test"
$ echo ${BASH_ALIASES[foo]}
echo test
$ echo `${BASH_ALIASES[foo]}` bar
test bar

# functions can be defined after execution
# empty line means sync


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
