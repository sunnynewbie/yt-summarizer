@echo off
setlocal EnableDelayedExpansion

:: Prompt for feature name
set /p FEATURE_NAME=Enter feature name (e.g. VideoSummary): 

:: Convert to snake_case (basic)
set SNAKE_CASE_FEATURE=
for %%A in (%FEATURE_NAME%) do (
    set "TEMP=%%A"
    call :ToSnakeCase !TEMP!
)

:: Check if backend folder exists
if not exist backend (
    echo ❌ 'backend' folder not found. Run this from the root of your project.
    goto :eof
)

:: Create shared folders if missing
if not exist backend\middlewares (
    mkdir backend\middlewares
    echo 📁 Created: backend\middlewares
)
if not exist backend\validations (
    mkdir backend\validations
    echo 📁 Created: backend\validations
)

:: Check if feature already exists
set FEATURE_PATH=backend\features\%SNAKE_CASE_FEATURE%
if exist %FEATURE_PATH% (
    echo ⚠️  Feature '%SNAKE_CASE_FEATURE%' already exists. Skipping.
    goto :eof
)

:: Create feature structure
mkdir %FEATURE_PATH%
echo // Controller logic > %FEATURE_PATH%\%SNAKE_CASE_FEATURE%.controller.js
echo // Service logic > %FEATURE_PATH%\%SNAKE_CASE_FEATURE%.service.js
echo // Route definitions > %FEATURE_PATH%\%SNAKE_CASE_FEATURE%.routes.js
echo // Data model or schema > %FEATURE_PATH%\%SNAKE_CASE_FEATURE%.model.js

echo ✅ Feature '%SNAKE_CASE_FEATURE%' created in backend\features\
goto :eof

:: Function to convert camelCase/PascalCase to snake_case (and lowercase)
:ToSnakeCase
setlocal EnableDelayedExpansion
set "input=%~1"
set "output="
set "char="
set "prev_lower=0"

for /l %%i in (0,1,254) do (
    set "char=!input:~%%i,1!"
    if "!char!"=="" goto break
    for %%U in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if "!char!"=="%%U" (
            if not "!output!"=="" (
                set "output=!output!_"
            )
            rem convert to lowercase using ASCII math
            set /a code=0x%%U + 32
            for /f %%L in ('powershell "[char](%code%)"') do set "char=%%L"
        )
    )
    set "output=!output!!char!"
)

:break
endlocal & set SNAKE_CASE_FEATURE=%output%
goto :eof
