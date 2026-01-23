@echo off
REM Quick redeploy script for Used Cars Marketplace
REM This script stops Tomcat, clears old deployment, and deploys fresh build

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║  Used Cars Marketplace - Quick Redeploy Script     ║
echo ╚════════════════════════════════════════════════════╝
echo.

set TOMCAT_PATH=C:\apache-tomcat-11.0.15
set PROJECT_PATH=d:\java-back-end

REM Step 1: Stop Tomcat
echo [1/4] Stopping Tomcat...
cd /d "%TOMCAT_PATH%\bin"
call shutdown.bat
echo [✓] Shutdown initiated. Waiting 5 seconds...
timeout /t 5 /nobreak

REM Step 2: Clear old deployment
echo.
echo [2/4] Clearing old deployment...
if exist "%TOMCAT_PATH%\webapps\java-back-end" (
    rmdir /s /q "%TOMCAT_PATH%\webapps\java-back-end"
    echo [✓] Removed java-back-end folder
)
if exist "%TOMCAT_PATH%\webapps\java-back-end.war" (
    del "%TOMCAT_PATH%\webapps\java-back-end.war"
    echo [✓] Removed java-back-end.war
)

REM Step 3: Copy new WAR file
echo.
echo [3/4] Deploying fresh build...
if exist "%PROJECT_PATH%\target\java-back-end.war" (
    copy "%PROJECT_PATH%\target\java-back-end.war" "%TOMCAT_PATH%\webapps\"
    echo [✓] WAR file deployed
) else (
    echo [ERROR] WAR file not found at %PROJECT_PATH%\target\java-back-end.war
    echo Please run: mvn clean install in %PROJECT_PATH%
    pause
    exit /b 1
)

REM Step 4: Start Tomcat
echo.
echo [4/4] Starting Tomcat...
cd /d "%TOMCAT_PATH%\bin"
call startup.bat

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║  Redeployment Complete!                            ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo Wait for Tomcat to fully start (watch for "Server startup in XXX ms")
echo.
echo Then test in your browser:
echo   http://localhost:8080/java-back-end
echo.
echo Expected flow:
echo   1. Register or Login
echo   2. Auto-redirected to Used Cars Marketplace
echo   3. See 8 cars in dashboard
echo.

pause
