@echo off
chcp 65001 > nul
if not defined VDMJ set VDMJ=%USERPROFILE%\.vscode\extensions\overturetool.vdm-vscode-2.0.0\resources\jars\vdmj\vdmj-4.7.0.jar
set MODELO=Tipos.vdmpp DispositivoUV.vdmpp CentralMonitoreo.vdmpp PruebasAlertaUV.vdmpp
cd /d "%~dp0"
title VDMJ 4.7.0 - Cobertura
echo VDMJ 4.7.0 - Sesion con los 16 casos y cobertura
echo.
java -jar "%VDMJ%" -vdmpp -i %MODELO% < pruebas.script 2>&1 | findstr /C:"Parsed" /C:"Type checked" /C:"Initialized" /C:"Test coverage for" /C:"Coverage ="
