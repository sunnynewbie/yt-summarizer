@echo off
setlocal EnableDelayedExpansion

:: Prompt for feature name
set /p FEATURE_NAME=Enter feature name (e.g. VideoSummary): 

:: Convert to lowercase and replace uppercase with _lowercase (basic snake_case)
set SNAKE_CASE_FEATURE=
for %%A in (%FEATURE_NAME%) do (
    set "TEMP=%%A"
    call :ToSnakeCase !TEMP!
)

:: Check if lib folder exists
if not exist lib (
    echo ❌ 'lib' directory not found. Make sure you're in the root of a Flutter project.
    goto :eof
)

:: Check if features folder exists inside lib
if not exist lib\features (
    echo 📁 'features' folder not found in lib\. Creating it...
    mkdir lib\features
)

:: Create folder structure
echo 📁 Creating feature structure: %SNAKE_CASE_FEATURE%
set FEATURE_PATH=lib\features\%SNAKE_CASE_FEATURE%

mkdir %FEATURE_PATH%
mkdir %FEATURE_PATH%\data
mkdir %FEATURE_PATH%\data\datasources
mkdir %FEATURE_PATH%\data\models
mkdir %FEATURE_PATH%\data\repositories

mkdir %FEATURE_PATH%\domain
mkdir %FEATURE_PATH%\domain\entities
mkdir %FEATURE_PATH%\domain\repositories
mkdir %FEATURE_PATH%\domain\usecases

mkdir %FEATURE_PATH%\presentation
mkdir %FEATURE_PATH%\presentation\bloc
mkdir %FEATURE_PATH%\presentation\pages
mkdir %FEATURE_PATH%\presentation\widgets

echo ✅ Clean Architecture folders created in: %FEATURE_PATH%
goto :eof

:: Function to convert to snake_case
:ToSnakeCase
setlocal EnableDelayedExpansion
set "input=%~1"
set "result="
for %%i in (%input%) do (
    set "word=%%i"
    set "word=!word:A=a!"
    set "word=!word:B=b!"
    set "word=!word:C=c!"
    set "word=!word:D=d!"
    set "word=!word:E=e!"
    set "word=!word:F=f!"
    set "word=!word:G=g!"
    set "word=!word:H=h!"
    set "word=!word:I=i!"
    set "word=!word:J=j!"
    set "word=!word:K=k!"
    set "word=!word:L=l!"
    set "word=!word:M=m!"
    set "word=!word:N=n!"
    set "word=!word:O=o!"
    set "word=!word:P=p!"
    set "word=!word:Q=q!"
    set "word=!word:R=r!"
    set "word=!word:S=s!"
    set "word=!word:T=t!"
    set "word=!word:U=u!"
    set "word=!word:V=v!"
    set "word=!word:W=w!"
    set "word=!word:X=x!"
    set "word=!word:Y=y!"
    set "word=!word:Z=z!"
)
:: insert underscores between camelCase transitions (basic)
set "word=%word:_= %"
set "word=%word: =_%"
endlocal & set SNAKE_CASE_FEATURE=%word%
goto :eof
