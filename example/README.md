Sample structure for testing.

TODO comment .git-keep where neeedi

# show tre with hidden files
tree -a .

# create a .git-keep in each folder
find . -type d -exec touch "{}/.git-keep" \;
