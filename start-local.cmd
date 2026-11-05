@echo off
REM One-click local setup + run (Windows). Keep this folder on a SHORT path such as D:\FundsIndia-Learning-Hub
cd /d "%~dp0"
if not exist node_modules ( call npm install || exit /b 1 )
if not exist .dev.vars copy .dev.vars.example .dev.vars >nul
call npm run build || exit /b 1
call npx wrangler d1 migrations apply fundsindia-hub --local || exit /b 1
call node seed\build-seed.mjs || exit /b 1
call node seed\apply.mjs --local || exit /b 1
echo.
echo Create the administrator accounts (run once) in PowerShell:
echo   $env:ADMIN_PASSWORD='your-password'; node scripts\create-admins.mjs --local rajesh.chakravarthi@fundsindia.com ashutosh.kumar@fundsindia.com ashwini.prabhu@fundsindia.com
echo.
echo Starting on http://127.0.0.1:8787   (admin portal: /staff-console)
call npx wrangler dev --port 8787
