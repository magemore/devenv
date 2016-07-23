#midnight commander

##Use Midnight Commander like a pro
http://klimer.eu/2015/05/01/use-midnight-commander-like-a-pro/
```
F10), your shell will automagically cd to that directory. This is done thanks to the mc-wrapper script that should be bundled with your installation of mc. The exact location is dependent on your distribution - in mine (Gentoo) it’s /usr/libexec/mc/, in Ubuntu supposedly it’s in /usr/share/mc/bin/. Once found, modify your ~/.bashrc:

alias mc='. /usr/libexec/mc/mc-wrapper
```
