#!/bin/bash

# prompt add msg | BROKEN

msg="Auto Commit $(date +%H%M)"

git add .
git commit -m "${msg}"
git push