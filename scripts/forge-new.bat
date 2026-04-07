@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Forge - New Project Generator
:: Usage: forge-new.bat [project-path] [type]
::   If no project-path given, initializes current directory.
::   type: full | backend | frontend | go | java | python | kotlin | ts
:: ============================================================

:: --- Locate Forge source (hardcoded for reliability) ---
set "FORGE_DIR=d:\projectse\everything-cursor_V2"

:: Fallback: try relative to script location
if not exist "%FORGE_DIR%\.cursor\rules" (
    set "FORGE_DIR=%~dp0.."
)

:: Verify Forge source exists
if not exist "%FORGE_DIR%\.cursor\rules\forge-identity.md" (
    echo.
    echo   [ERROR] Cannot find Forge source rules.
    echo   Searched: %FORGE_DIR%\.cursor\rules\
    echo.
    echo   Fix: edit FORGE_DIR in this script to point to your Forge repo.
    echo.
    exit /b 1
)

:: --- Parse arguments ---
set "TARGET=%~1"
set "TYPE=%~2"

:: No arguments: show menu
if "%TARGET%"=="" goto :MENU
:: Argument is a known type (not a path): init current dir with that type
if "%TARGET%"=="full"     ( set "TYPE=full"     & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="backend"  ( set "TYPE=backend"  & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="frontend" ( set "TYPE=frontend" & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="go"       ( set "TYPE=go"       & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="java"     ( set "TYPE=java"     & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="python"   ( set "TYPE=python"   & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="kotlin"   ( set "TYPE=kotlin"   & set "TARGET=%CD%" & goto :RUN )
if "%TARGET%"=="ts"       ( set "TYPE=ts"       & set "TARGET=%CD%" & goto :RUN )
:: Argument is a path
if "%TYPE%"=="" set "TYPE=full"
goto :RUN

:MENU
echo.
echo   ========================================
echo     Forge v1.2 - New Project Generator
echo   ========================================
echo.
echo   Select project type:
echo.
echo     [1] full      All languages + frontend
echo     [2] backend   All backend languages
echo     [3] frontend  TypeScript + frontend
echo     [4] go        Go only
echo     [5] java      Java only
echo     [6] python    Python only
echo     [7] kotlin    Kotlin only
echo     [8] ts        TypeScript only
echo.
echo   Target: %CD%
echo.
set /p "CHOICE=  Enter choice [1-8, default=1]: "
if "%CHOICE%"=="" set "CHOICE=1"
if "%CHOICE%"=="1" set "TYPE=full"
if "%CHOICE%"=="2" set "TYPE=backend"
if "%CHOICE%"=="3" set "TYPE=frontend"
if "%CHOICE%"=="4" set "TYPE=go"
if "%CHOICE%"=="5" set "TYPE=java"
if "%CHOICE%"=="6" set "TYPE=python"
if "%CHOICE%"=="7" set "TYPE=kotlin"
if "%CHOICE%"=="8" set "TYPE=ts"
set "TARGET=%CD%"
goto :RUN

:RUN
:: Validate target doesn't already have .cursor rules
if exist "%TARGET%\.cursor\rules\forge-identity.md" (
    echo.
    echo   [!] Forge rules already exist in: %TARGET%\.cursor\rules\
    echo       Delete .cursor\rules\ first, or choose a different path.
    echo.
    exit /b 1
)

:: Create target directory
if not exist "%TARGET%" mkdir "%TARGET%"

echo.
echo   Forge v1.2 - Initializing project
echo   ======================================
echo   Source: %FORGE_DIR%
echo   Target: %TARGET%
echo   Type:   %TYPE%
echo.

:: Step 1: Copy common rules + forge rules + settings
echo   [1/4] Copying common rules...
mkdir "%TARGET%\.cursor\rules" 2>nul
for %%f in ("%FORGE_DIR%\.cursor\rules\common-*.md") do (
    copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
copy /Y "%FORGE_DIR%\.cursor\rules\forge-identity.md" "%TARGET%\.cursor\rules\" >nul
copy /Y "%FORGE_DIR%\.cursor\rules\forge-extensibility.md" "%TARGET%\.cursor\rules\" >nul
if exist "%FORGE_DIR%\.cursor\settings.json" (
    copy /Y "%FORGE_DIR%\.cursor\settings.json" "%TARGET%\.cursor\" >nul
)

:: Step 2: Copy language-specific rules based on type
echo   [2/4] Copying language rules [%TYPE%]...

if "%TYPE%"=="full" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\golang-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\typescript-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\python-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\kotlin-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\java-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\frontend-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="backend" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\golang-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\typescript-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\python-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\kotlin-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\java-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="frontend" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\typescript-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\frontend-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="go" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\golang-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="java" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\java-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="python" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\python-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="kotlin" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\kotlin-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
if "%TYPE%"=="ts" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\typescript-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\frontend-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)

:: Step 3: Count results
echo   [3/4] Verifying...
set count=0
for %%f in ("%TARGET%\.cursor\rules\*.md") do set /a count+=1

:: Step 4: Summary
echo   [4/4] Done!
echo.
echo   ========================================
echo     Forge Project Created
echo   ========================================
echo     Path:   %TARGET%
echo     Type:   %TYPE%
echo     Rules:  !count! rules installed
echo     Skills: Global (no action needed)
echo   ========================================
echo.

endlocal
