@echo off
chcp 65001 > nul
if not defined VDMJ set VDMJ=%USERPROFILE%\.vscode\extensions\overturetool.vdm-vscode-2.0.0\resources\jars\vdmj\vdmj-4.7.0.jar
set MODELO=Tipos.vdmpp DispositivoUV.vdmpp CentralMonitoreo.vdmpp PruebasAlertaUV.vdmpp
cd /d "%~dp0"
title VDMJ 4.7.0 - Casos de exito CP01 a CP08
echo VDMJ 4.7.0 - Casos de exito CP01 a CP08
echo.
echo ^> print new PruebasAlertaUV().CP01_LecturaExtrema()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP01_LecturaExtrema()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP02_LecturaModerada()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP02_LecturaModerada()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP03_EnElUmbral()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP03_EnElUmbral()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP04_BajoElUmbral()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP04_BajoElUmbral()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP05_FueraDeRango()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP05_FueraDeRango()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP06_JornadaArequipa()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP06_JornadaArequipa()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP07_CicloDeAlerta()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP07_CicloDeAlerta()" %MODELO% 2>&1
echo ^> print new PruebasAlertaUV().CP08_ConsultaPorZona()
java -jar "%VDMJ%" -vdmpp -q -e "new PruebasAlertaUV().CP08_ConsultaPorZona()" %MODELO% 2>&1
