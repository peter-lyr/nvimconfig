@echo off
set var=%~1
if not defined var (
  exit /b
)
echo ====================================
git diff --stat
echo ====================================
set var2=
set /p var2=Sure to add all and push? (Empty for yes):
if not defined var2 (
  git add -A
  git status
  git commit -m "%var%"
  git push
)
