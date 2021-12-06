@echo off
set "emtpy="
setlocal enableextensions enabledelayedexpansion
goto getpath

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

:NoArg
	echo Please fill all arguments^!
	echo.
	goto helping


:Normal
	set "prev=Normal"
	echo Depot1 is %DepotID_1% , Manifest1 is %ManifestID_1% 
	echo Depot2 is %DepotID_2% , Manifest2 is %ManifestID_2%
	echo Path is %DownPath% , UserName is %username%
	echo.
	dotnet DepotDownloader/DepotDownloader.dll -app 359550 -depot %DepotID_1% -manifest %ManifestID_1% -username %username% -remember-password -dir "%DownPath%" -validate -max-servers 15 -max-downloads 10
	echo.
	dotnet DepotDownloader/DepotDownloader.dll -app 359550 -depot %DepotID_2% -manifest %ManifestID_2% -username %username% -remember-password -dir "%DownPath%" -validate -max-servers 15 -max-downloads 10
	echo.
	echo Download is completed^!
	goto pasteplazas


:Extra
	set "prev=Extra"
	echo Extra, Depot is %DepotID% and Manifest is %ManifestID% ^| Path is %DownPath% , UserName is %username%
	echo.
	dotnet DepotDownloader/DepotDownloader.dll -app %AppID% -depot %DepotID% -manifest %ManifestID% -username %username% -remember-password -dir "%DownPath%" -validate -max-servers 15 -max-downloads 10
	echo Download is completed^!
	goto verifing

:Compressed
	set "prev=Compressed"
	echo Depot1 is %DepotID_1% , Manifest1 is %ManifestID_1%  ^| Depot2 is %DepotID_2% , Manifest2 is %ManifestID_2%
	echo Path is %DownPath% , UserName is %username% ^| File1 is %File1% , File2 is %File2%
	echo.
	dotnet DepotDownloader/DepotDownloader.dll -app 359550 -depot %DepotID_1% -manifest %ManifestID_1% -username %username% -remember-password -dir "%DownPath%" -filelist %File1% -validate -max-servers 15 -max-downloads 10
	echo.
	dotnet DepotDownloader/DepotDownloader.dll -app 359550 -depot %DepotID_2% -manifest %ManifestID_2% -username %username% -remember-password -dir "%DownPath%" -filelist %File2% -validate -max-servers 15 -max-downloads 10    
	echo.
	echo Download is completed^!
	goto pasteplazas

:helping
	echo.   	 Welcome to AIO-Tool Batch Extension^^!
	echo.
	echo USAGE:
	echo   DL.bat 1 "Depot1" "Manifest1" "Depot2" "Manifest2" "Path/Folder" "UserName"
	echo.   OR 
	echo   DL.bat 2 "Depot" "Manifest" "Path/Folder" "UserName"
	echo.   OR 
	echo   DL.bat 3 "Depot1" "Manifest1" "Depot2" "Manifest2" "Path/Folder" "UserName" "files1" "files2"
	echo.
	echo.  Path need to use with "Example\Path1\Path2"
	echo.
	echo.  Files need to be with path or paste near to this tool
	echo.  File need to use with .txt like:
	echo.                      Example\Path\filelist1.txt
	echo.
	echo.  You can use 1 to Normal
	echo.  You can use 2 to Extra
	echo.  You can use 3 to Compressed
	echo.
	echo %*
	goto end

:initextra
	set "AppID=%2"
	set "DepotID=%3"
	set "ManifestID=%4"
	set "username=%5"
	goto Extra

:initcompressed
	set "DepotID_1=%2"
	set "ManifestID_1=%3"
	set "DepotID_2=%4"
	set "ManifestID_2=%5"	
	set "username=%6"
	set "File1=%7"
	set "File2=%8"
	set "PlazaDir=%9"
	goto Compressed

:initnormal
	set "DepotID_1=%2"
	set "ManifestID_1=%3"
	set "DepotID_2=%4"
	set "ManifestID_2=%5"
	set "username=%6"
	set "PlazaDir=%7"
	goto Normal

:ifstates
	if "%~1"=="" (goto helping)
	if "%~1"== "/?" (goto helping)
	if "%~1"== "-?" (goto helping)
	if "%~1"== "-help" (goto helping)

	if "%1"=="1" (goto if1)
	if "%1"=="2" (goto if2)
	if "%1"=="3" (goto if3)

	if "%1"=="Normal" (goto if1)
	if "%1"=="Extra" (goto if2)
	if "%1"=="Compressed" (goto if3)

	goto helping

:if1
	echo Normal
	if /i "%2"=="" (goto NoArg)
	if /i "%3"=="" (goto NoArg)
	if /i "%4"=="" (goto NoArg)
	if /i "%5"=="" (goto NoArg)
	if /i "%6"=="" (goto NoArg)
	goto initnormal

:if2
	echo Extra
	if /i "%2"=="" (goto NoArg)
	if /i "%3"=="" (goto NoArg)
	if /i "%4"=="" (goto NoArg)
	if /i "%5"=="" (goto NoArg)
	goto initextra

:if3
	echo Compressed
	if /i "%2"=="" (goto NoArg)
	if /i "%3"=="" (goto NoArg)
	if /i "%4"=="" (goto NoArg)
	if /i "%5"=="" (goto NoArg)
	if /i "%6"=="" (goto NoArg)
	if /i "%7"=="" (goto NoArg)
	if /i "%8"=="" (goto NoArg)
	goto initcompressed

:getpath
	for /f "tokens=* delims=" %%x in (path.txt) do set DownPath=%%x
	echo %DownPath%
	goto ifstates

:pasteplazas
	echo.
	echo [%PlazaDir%]
	if [%PlazaDir%]==[%empty%] (
	echo Plazadir is Empty, nothing got moved
	)
	if NOT [%PlazaDir%]==[] (
	echo Plazadir is NOT Empty, copy started..
	robocopy Plazas\%PlazaDir% %DownPath% /S>copy.txt
	echo Copy finished
	)
	goto verifing

:verifing
	echo.
	echo You want to verify?
	echo 1 : Yes ^| 2 : No 
	set /p veri="Enter here: "

	if "%veri%"=="1" (
		goto %prev%
	)
	if "%veri%"=="2" (
		goto end
	)
	goto verifing

:end
	set "DownPath="
	set "username="
	set "DepotID="
	set "ManifestID="
	set "DepotID_1="
	set "ManifestID_1="
	set "DepotID_2="
	set "ManifestID_2="	
	set "File1="
	set "File2="
	set "veri="
	set "prev="
	set "AppID="
	set "PlazaDir="
	pause
