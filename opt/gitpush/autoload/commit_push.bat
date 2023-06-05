@echo off
set var=%~1
if not defined var (
  exit /b
)
echo ====================================
git status
echo ====================================
set var2=
set /p var2=Sure to just push? (Empty for yes): 
if not defined var2 (
  git commit -m "%var%"
  git push
)
