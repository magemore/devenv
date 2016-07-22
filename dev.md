#dev

- [ ] make automatic commits and pushes of mage/devenv by cron
  - at the moment its commited and pushed on vim save. for sumblime just save without touching git

- [ ] fix bin bash path something strange path duplicates alot
  - [ ] google bash path duplicates
  - [ ] try to reboot and check

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

