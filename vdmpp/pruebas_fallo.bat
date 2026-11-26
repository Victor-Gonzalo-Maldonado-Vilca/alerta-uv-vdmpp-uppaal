@echo off
chcp 65001 > nul
if not defined VDMJ set VDMJ=%USERPROFILE%\.vscode\extensions\overturetool.vdm-vscode-2.0.0\resources\jars\vdmj\vdmj-4.7.0.jar
set MODELO=Tipos.vdmpp DispositivoUV.vdmpp CentralMonitoreo.vdmpp PruebasAlertaUV.vdmpp
cd /d "%~dp0"
title VDMJ 4.7.0 - Casos de fallo CP09 a CP16
echo VDMJ 4.7.0 - Casos de fallo CP09 a CP16
echo.
echo ^> print new PruebasAlertaUV().CP09_SinLecturaConIndice()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP09_SinLecturaConIndice()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP10_OperativoFueraDeRango()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP10_OperativoFueraDeRango()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP11_SensorNoInstalado()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP11_SensorNoInstalado()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP12_LecturaDesordenada()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP12_LecturaDesordenada()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP13_AlertaFalsa()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP13_AlertaFalsa()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP14_NivelMalClasificado()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP14_NivelMalClasificado()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP15_AtenderSinEmitir()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP15_AtenderSinEmitir()" %MODELO% 2>&1 | findstr /B /C:"Execution"
echo ^> print new PruebasAlertaUV().CP16_DispositivoDuplicado()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP16_DispositivoDuplicado()" %MODELO% 2>&1 | findstr /B /C:"Execution"
