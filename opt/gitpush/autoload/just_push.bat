@echo off
set var=%~1
echo ====================================
git status
echo ====================================
if %var% EQU yes (
  git push
) else if %var% EQU force (
  git push -f
)
