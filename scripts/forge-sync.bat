@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ============================================================
:: Forge — Skills Sync for New Machine
:: Copies user-level skills from this repo to ~/.cursor/skills/
:: Usage: forge-sync.bat [--force]
::   --force: overwrite existing skills without asking
:: ============================================================

set "FORGE_DIR=%~dp0.."
set "SKILLS_SOURCE=%FORGE_DIR%\skills"
set "SKILLS_TARGET=%USERPROFILE%\.cursor\skills"
set "FORCE=%~1"

echo.
echo   ╔══════════════════════════════════════════════════╗
echo   ║          Forge — Skills Sync                     ║
echo   ╚══════════════════════════════════════════════════╝
echo.

:: Check if skills source exists
if not exist "%SKILLS_SOURCE%" (
    echo   [!] Skills source not found: %SKILLS_SOURCE%
    echo       This repo doesn't have a skills/ directory yet.
    echo       Run this script from the Forge repository root.
    echo.
    echo   Note: If you only need project rules, use forge-new.bat instead.
    echo         User skills may already be configured in %SKILLS_TARGET%
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
            echo   [^>] Updated: !SKILL_NAME!
            set /a synced+=1
        ) else (
            echo   [-] Skipped: !SKILL_NAME! (already exists, use --force to overwrite)
            set /a skipped+=1
        )
    ) else (
        xcopy /Y /E /I "!SKILL_SRC!" "!SKILL_DST!" >nul 2>nul
        echo   [+] Installed: !SKILL_NAME!
        set /a synced+=1
    )
)

echo.
echo   ──────────────────────────────────────
echo   Synced:  !synced! skills
echo   Skipped: !skipped! skills (use --force to overwrite)
echo   Target:  %SKILLS_TARGET%
echo.
echo   Skills are now globally available in all Cursor projects.
echo.

endlocal
