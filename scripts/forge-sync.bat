@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Forge - Skills Sync for New Machine
:: Copies user-level skills from this repo to ~/.cursor/skills/
:: Usage: forge-sync.bat [--force]
::   --force: overwrite existing skills without asking
:: ============================================================

set "FORGE_DIR=%~dp0.."
set "SKILLS_SOURCE=%FORGE_DIR%\skills"
set "SKILLS_TARGET=%USERPROFILE%\.cursor\skills"
set "FORCE=%~1"

echo.
echo   ========================================
echo     Forge v1.4 - Skills ^& Experiences Sync
echo   ========================================
echo.

:: Check if skills source exists
if not exist "%SKILLS_SOURCE%" (
    echo   [!] Skills source not found: %SKILLS_SOURCE%
    echo.
    echo       This repo does not have a skills/ directory.
    echo       User skills may already be configured at:
    echo       %SKILLS_TARGET%
    echo.
    echo       To use this script, copy your skills into:
    echo       %SKILLS_SOURCE%
    echo.
    exit /b 1
)

:: Create target if needed
if not exist "%SKILLS_TARGET%" (
    echo   Creating %SKILLS_TARGET%...
    mkdir "%SKILLS_TARGET%"
)

:: Sync each skill directory
set synced=0
set skipped=0
for /d %%d in ("%SKILLS_SOURCE%\*") do (
    set "SKILL_NAME=%%~nxd"
    set "SKILL_SRC=%%d"
    set "SKILL_DST=%SKILLS_TARGET%\!SKILL_NAME!"

    if exist "!SKILL_DST!\SKILL.md" (
        if "%FORCE%"=="--force" (
            xcopy /Y /E /I "!SKILL_SRC!" "!SKILL_DST!" >nul 2>nul
            echo   [Updated]   !SKILL_NAME!
            set /a synced+=1
        ) else (
            echo   [Skipped]   !SKILL_NAME! (exists, use --force to overwrite)
            set /a skipped+=1
        )
    ) else (
        xcopy /Y /E /I "!SKILL_SRC!" "!SKILL_DST!" >nul 2>nul
        echo   [Installed] !SKILL_NAME!
        set /a synced+=1
    )
)

:: --- Experience Store Setup ---
echo.
echo   Checking experience store...
set "EXP_DIR=%USERPROFILE%\.cursor\experiences"
set exp_created=0
if not exist "%EXP_DIR%" (
    for %%c in (build-errors logic-errors config-issues dependency-issues runtime-errors performance-issues security-issues other) do (
        mkdir "%EXP_DIR%\%%c" 2>nul
    )
    echo   [Created]   Experience store: %EXP_DIR%
    set exp_created=1
) else (
    :: Ensure all category directories exist
    for %%c in (build-errors logic-errors config-issues dependency-issues runtime-errors performance-issues security-issues other) do (
        if not exist "%EXP_DIR%\%%c" (
            mkdir "%EXP_DIR%\%%c" 2>nul
            echo   [Created]   %EXP_DIR%\%%c
            set /a exp_created+=1
        )
    )
    if !exp_created!==0 (
        echo   [OK]        Experience store already complete.
    )
)

echo.
echo   ========================================
echo     Sync Complete
echo   ========================================
echo     Skills synced:  !synced!
echo     Skills skipped: !skipped!
echo     Skills target:  %SKILLS_TARGET%
echo     Experiences:    %EXP_DIR%
echo   ========================================
echo.
echo   Skills and experiences are now globally available.
echo.

endlocal
