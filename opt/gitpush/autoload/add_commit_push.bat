@echo off
set var=%~1
git add -A
git status
git commit -m "%var%"
git push
