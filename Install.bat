@echo off
chcp 65001
setlocal enableextensions enabledelayedexpansion
set homepath=%cd%


MODE 78,20
echo ------------------------------------------------------------------------------
echo                        Downloading AllInOne Tools [C#]...
echo ------------------------------------------------------------------------------
curl -L  "https://drive.google.com/uc?id=1DZa44Z4kg2-0g7gmuNFdaWfv4hwK4CXh&authuser=0&export=download" --output AIO-Tools.exe
cls
exit
