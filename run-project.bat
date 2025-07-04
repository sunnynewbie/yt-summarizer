@echo off
setlocal

:: Configure paths - adjust these according to your project structure
set PYTHON_VENV_PATH=.\venv\Scripts\activate
set BACKEND_DIR=.\backend

:: Check environment argument
if "%1"=="" (
    echo Error: Please specify environment [dev|release]
    exit /b 1
)

:: Activate Python virtual environment
if exist "%PYTHON_VENV_PATH%" (
    call "%PYTHON_VENV_PATH%"
) else (
    echo Error: Python virtual environment not found at %PYTHON_VENV_PATH%
    exit /b 1
)

:: Change to backend directory
cd /d "%BACKEND_DIR%" 2>nul || (
    echo Error: Backend directory not found - %BACKEND_DIR%
    exit /b 1
)

:: Run Node.js based on environment
if /i "%1"=="dev" (
    echo Starting development server...
    nodemon index
) else if /i "%1"=="release" (
    echo Starting production server...
    node index.js
) else (
    echo Invalid environment argument: %1
    echo Valid options: dev, release
    exit /b 1
)

endlocal