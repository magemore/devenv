# devenv

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

so executing some system script may look like
  exec ls ->
    for $1 as d
      if todo in d than exec process_todo ->
        if $1 == done -> say ^

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


i like idea of attaching some machine learning or it maybe fun to attach human processing units.
amazon turk in order to help my scripts logic to act more like human. but this part seems complicated at the moment.
i will not write all at once. it's a side project and i write it just for fun. in any direction.
if i feel like i need something i just write it in 10 minutes or so.

termux enables me to write things from my phone offline anywhere.
reminders should sync and have offline phone mode.

code maybe random quality. it's just hacking things for fun of it and making somewhat smart pc that adapts to my activities. kinda my external mind that thinks on it's own and completes my mind. it's a vision of project a dream.
in real expect lots of messy or even stupid scripts if you bother to read.
