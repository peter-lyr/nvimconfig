@echo off
set var=%~1
if not defined var (
  exit /b
)
set var2=
set /p var2=Sure to add all and commit? (Empty for yes): 
if not defined var2 (
  git add -A
  echo ====================================
  git status
  echo ====================================
  git commit -m "%var%"
)
