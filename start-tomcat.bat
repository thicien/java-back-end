@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-21
set CATALINA_HOME=C:\apache-tomcat-11.0.15-windows-x64\apache-tomcat-11.0.15
set MAVEN_HOME=C:\apache-maven-3.9.6

echo Starting Tomcat 11...
echo Listening on http://localhost:8080/java-back-end
echo Bus Ticket Booking System
echo.
call "%CATALINA_HOME%\bin\catalina.bat" run
