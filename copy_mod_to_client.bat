@echo off
set dockerpath="%programfiles%\Docker\Docker\Docker Desktop.exe"
set attempts=20

echo Checking if Docker is currently running...
:openDocker
docker info | find /i "Server Version">NUL
if %errorlevel% equ 0 (
	goto :dockerSuccess
) 
if %errorlevel% equ 1 (
	echo Attempts left: %attempts% 
	if %attempts% equ 20 (
		start "" %dockerpath% && echo Starting Docker...
	)
	set /a attempts-=1 
	timeout /t 2 /nobreak > NUL 
	goto :openDocker
)
echo Unable to start Docker. Exiting... 
pause 
exit

:dockerSuccess
echo Docker is running.

set containerName="mc-dev"
set serviceName="dev"

echo Checking if development containers are running...
docker ps --filter "name=%containerName%" --filter "status=running" | find /i %containerName%>NUL
if %errorlevel% equ 0 (
	goto :containerSuccess
) 
if %errorlevel% equ 1 (
	docker ps --filter "name=%containerName%" | find /i %containerName%>NUL
	if %errorlevel% equ 0 (
		goto :startContainer
	) 
	if %errorlevel% equ 1 (
		goto :createContainer
	)
)
:createContainer
echo Creating development container...
docker compose create --build %serviceName%

:startContainer
echo Starting development container...
docker compose start %serviceName%

:containerSuccess
echo Development container %containerName% is running.

set volumeName=builds
set minecraftModsPath="%userprofile%\AppData\Roaming\.minecraft\mods"

echo Copying mod files to client minecraft mods folder...
cd %minecraftModsPath%
for /f %%i in ('docker run -d -v %volumeName%:/%volumeName% busybox true') do (
	docker cp %%i:/%volumeName% ./
	docker rm %%i
)
cd %volumeName%
for /r "./" %%i in (*) do move /Y %%i ..
cd ..
rmdir %volumeName%
pause
exit