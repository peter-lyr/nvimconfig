@echo off
set var=%~1
if not defined var (
  timeout /t 3
  exit /b
)
set var2=
set /p var2=Sure to add all and push? (Empty for yes):
if not defined var2 (
  git add -A
  echo ====================================
  git status
  echo ====================================
  git commit -m "%var%"
  git push
)
timeout /t 3
