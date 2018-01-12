@echo off
echo enter the command:
:start
  node main_new.js
  if ERRORLEVEL 1 goto  error
goto start
:error
