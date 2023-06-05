@echo off
set var=%~1
if %var% EQU yes (
  git push
) else if %var% EQU force (
  git push -f
)
