@echo off
:start
  node main_new.js
  if ERRORLEVEL 1 goto  error
goto start
:error
