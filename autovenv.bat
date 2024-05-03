@echo off
setlocal enabledelayedexpansion

if "%~2"=="" (
    echo Usage: %0 [venv_path] [raw_github_file_url]
    exit /b 1
)
set "venvpath=%~1"
set "githuburl=%~2"

if not exist "%venvpath%\Scripts\python.exe" (
    echo Creating Python virtual environment at %venvpath%
    python -m venv "%venvpath%"
) else (
    echo Virtual environment already exists at %venvpath%
)

if not exist "%venvpath%\requirements.snapshot.txt" (
    echo Creating empty requirements.snapshot.txt
    type nul > "%venvpath%\requirements.snapshot.txt"
)

powershell -Command "(Invoke-WebRequest -Uri '%githuburl%').Content > %venvpath%\new_requirements.snapshot.txt"

echo Checking for updates in requirements...
fc "%venvpath%\requirements.snapshot.txt" "%venvpath%\new_requirements.snapshot.txt" > nul
if errorlevel 1 (
    echo Differences found, updating requirements.snapshot.txt...
    copy /y "%venvpath%\new_requirements.snapshot.txt" "%venvpath%\requirements.snapshot.txt"
    set "updated=true"
) else (
    echo No update needed.
    set "updated=false"
)

if "!updated!"=="true" (
    echo Installing updated requirements...
    "%venvpath%\Scripts\python.exe" -m pip install -r "%venvpath%\requirements.snapshot.txt"
)

del "%venvpath%\new_requirements.snapshot.txt"

echo Script completed successfully. Please activate your virtual environment manually to use it.
echo If you want to reinstall the requirements, please remove the snapshot file:
echo %venvpath%\requirements.snapshot.txt   
endlocal
