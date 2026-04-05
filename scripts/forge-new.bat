@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Forge — New Project Generator
:: Creates a new project directory with Forge rules pre-installed
:: Usage: forge-new.bat "D:\projects\my-project" [type]
::   type: full | backend | frontend | go | java | python | kotlin
:: ============================================================

set "FORGE_DIR=%~dp0.."
set "TARGET=%~1"
set "TYPE=%~2"

if "%TARGET%"=="" (
    echo.
    echo   ╔══════════════════════════════════════════════════╗
    echo   ║          Forge — New Project Generator           ║
    echo   ╚══════════════════════════════════════════════════╝
    echo.
    echo   Usage: forge-new.bat ^<project-path^> [type]
    echo.
    echo   Types:
    echo     full      All languages + frontend (default)
    echo     backend   All backend languages, no frontend
    echo     frontend  TypeScript + frontend engineering
    echo     go        Go only
    echo     java      Java only
    echo     python    Python only
    echo     kotlin    Kotlin only
    echo     ts        TypeScript only
    echo.
    echo   Example:
    echo     forge-new.bat "D:\projects\my-api" go
    echo     forge-new.bat "D:\projects\my-app" frontend
    echo     forge-new.bat "D:\projects\my-project"
    echo.
    exit /b 1
)

if "%TYPE%"=="" set "TYPE=full"

:: Validate target doesn't already have .cursor
if exist "%TARGET%\.cursor\rules" (
    echo.
    echo   [!] %TARGET%\.cursor\rules already exists.
    echo       Delete it first or choose a different path.
    echo.
    exit /b 1
)

:: Create target directory
if not exist "%TARGET%" mkdir "%TARGET%"

echo.
echo   Forge v1.2 — Initializing new project
echo   ──────────────────────────────────────
echo   Target: %TARGET%
echo   Type:   %TYPE%
echo.

:: Step 1: Copy common rules (always needed)
echo   [1/4] Copying common rules...
mkdir "%TARGET%\.cursor\rules" 2>nul
for %%f in ("%FORGE_DIR%\.cursor\rules\common-*.md") do (
    copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
)
copy /Y "%FORGE_DIR%\.cursor\rules\forge-identity.md" "%TARGET%\.cursor\rules\" >nul
copy /Y "%FORGE_DIR%\.cursor\rules\forge-extensibility.md" "%TARGET%\.cursor\rules\" >nul
copy /Y "%FORGE_DIR%\.cursor\settings.json" "%TARGET%\.cursor\" >nul

:: Step 2: Copy language-specific rules based on type
echo   [2/4] Copying language rules [%TYPE%]...

if "%TYPE%"=="full" (
    for %%f in ("%FORGE_DIR%\.cursor\rules\golang-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\typescript-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\python-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\kotlin-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    for %%f in ("%FORGE_DIR%\.cursor\rules\java-*.md") do copy /Y "%%f" "%TARGET%\.cursor\rules\" >nul
    copy /Y "%FORGE_DIR%\.cursor\rules\frontend-engineering.md" "%TARGET%\.cursor\rules\" >nul
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
    copy /Y "%FORGE_DIR%\.cursor\rules\frontend-engineering.md" "%TARGET%\.cursor\rules\" >nul
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
    copy /Y "%FORGE_DIR%\.cursor\rules\frontend-engineering.md" "%TARGET%\.cursor\rules\" >nul
)

:: Step 3: Count results
echo   [3/4] Verifying...
set count=0
for %%f in ("%TARGET%\.cursor\rules\*.md") do set /a count+=1

:: Step 4: Summary
echo   [4/4] Done!
echo.
echo   ╔══════════════════════════════════════════════════╗
echo   ║           Forge Project Created                  ║
echo   ╠══════════════════════════════════════════════════╣
echo   ║  Path:  %TARGET%
echo   ║  Type:  %TYPE%
echo   ║  Rules: !count! rules installed
echo   ║  Skills: Global (no action needed)
echo   ╚══════════════════════════════════════════════════╝
echo.
echo   Next steps:
echo     cd "%TARGET%"
echo     cursor .
echo.

endlocal
