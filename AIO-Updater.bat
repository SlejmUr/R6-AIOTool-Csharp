@echo off
setlocal enableextensions enabledelayedexpansion

if exist "Data\Update\AIO-Tools.exe" (
mkdir Data\Old >nul
move AIO-Tools.exe Data\Old >nul
move Data\Update\AIO-Tools.exe . >nul
rd /s /q Data\Update
::rd /s /q Data\Old
echo Update Successful^!
) else (
echo Update file not found, probably you running the newest version^!
)
pause
