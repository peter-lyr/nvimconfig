@echo off
set var=%~1
if not defined var (
  timeout /t 3
  exit /b
)
set var2=
set /p var2=Sure to just commit? (Empty for yes): 
if not defined var2 (
  git commit -m "%var%"
)
timeout /t 3
