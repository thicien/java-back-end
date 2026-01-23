@echo off
REM Deploy New Car Marketplace Dashboard
REM This script will stop Tomcat, remove old deployment, deploy fresh WAR, and restart Tomcat

echo.
echo ==========================================
echo   DriveSelect Car Marketplace Deployment
echo ==========================================
echo.

REM Set Tomcat path
set TOMCAT_HOME=C:\apache-tomcat-11.0.15
set WEBAPPS=%TOMCAT_HOME%\webapps
set TARGET_WAR=d:\java-back-end\target\java-back-end.war

echo Step 1: Stopping Tomcat...
call "%TOMCAT_HOME%\bin\shutdown.bat"
timeout /t 3 /nobreak

echo.
echo Step 2: Removing old deployment...
if exist "%WEBAPPS%\java-back-end" (
    rmdir /s /q "%WEBAPPS%\java-back-end"
    echo   - Removed old java-back-end folder
)

if exist "%WEBAPPS%\java-back-end.war" (
    del "%WEBAPPS%\java-back-end.war"
    echo   - Removed old java-back-end.war
)

echo.
echo Step 3: Deploying fresh build...
if exist "%TARGET_WAR%" (
    copy "%TARGET_WAR%" "%WEBAPPS%\java-back-end.war"
    echo   - Deployed fresh java-back-end.war
) else (
    echo   ERROR: WAR file not found at %TARGET_WAR%
    echo   Build the project first: mvn clean install
    pause
    exit /b 1
)

echo.
echo Step 4: Starting Tomcat...
call "%TOMCAT_HOME%\bin\startup.bat"
timeout /t 5 /nobreak

echo.
echo ==========================================
echo   Deployment Complete!
echo ==========================================
echo.
echo Please follow these steps:
echo   1. Clear your browser cache (Ctrl+Shift+Delete)
echo   2. Close all browser windows
echo   3. Open a new browser window
echo   4. Visit: http://localhost:8080/java-back-end
echo   5. Login with your credentials
echo   6. You should see the new car marketplace dashboard
echo.
echo Expected to see:
echo   - Beautiful DriveSelect header
echo   - Hero section with "Find Your Next Adventure"
echo   - Car grid with condition filters
echo   - Search functionality
echo   - Modal car details popup
echo.
pause
