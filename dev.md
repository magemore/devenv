#dev

# coding from phone
- [ ] delete some nodejs packages and find out what takes up to 8Gb internal space
  - [ ] maybe root the phone than i can use sd card and etc

## from phone for web dev use vlad laptop over ssh from termux when pc is turned off it works almost with no noise.


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

