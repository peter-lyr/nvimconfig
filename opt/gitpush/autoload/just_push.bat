@echo off
set var=%~1
echo ====================================
git diff --stat
echo ====================================
if %var% EQU yes (
  git push
) else if %var% EQU force (
  git push -f
)
