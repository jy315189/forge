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
echo     Forge - Skills Sync
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

echo.
echo   ========================================
echo     Sync Complete
echo   ========================================
echo     Synced:  !synced! skills
echo     Skipped: !skipped! skills
echo     Target:  %SKILLS_TARGET%
echo   ========================================
echo.
echo   Skills are now globally available in all Cursor projects.
echo.

endlocal
