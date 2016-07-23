#dev

# huboard track github issues
https://huboard.com/magemore/devenv/

# coding from phone
- [ ] delete some nodejs packages and find out what takes up to 8Gb internal space
  - [ ] maybe root the phone than i can use sd card and etc

### node modules taking less space than i expected
 - in general termux uses near 2Gb
 - [ ] so whats taking other 6Gb? is it android itself?
```
442M	node_modules
```
- [ ] move node modules to sd card from usb connected and link node_modules folder to sdcard path it will save space

## from phone for web dev use vlad laptop over ssh from termux when pc is turned off it works almost with no noise.

### http-server nice to play with webdev client side. still it's better to switch to laptop if possible.
  - hovewer it's cool that i can do it from phone offline somewhere when waiting for the line in a shop
  - so nodejs just as android game

#termux
```bash
termux-vibrate 
# for attention

termux-dialog 
#nice for text input use for todo lists adding new todo

```


It's easy enough to avoid adding duplicate entries.
```bash
case ":$PATH:" in
  *":$new_entry:"*) :;; # already there
  *) PATH="$new_entry:$PATH";; # or PATH="$PATH:$new_entry"
esac
```

## synergy
- [ ] write script to restart synergy on clipboard change

