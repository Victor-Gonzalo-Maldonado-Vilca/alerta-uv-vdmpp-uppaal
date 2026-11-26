@echo off
REM Verifica las 11 propiedades del modelo UPPAAL y guarda la salida.
REM Requiere UPPAAL 5.0 instalado en la ruta por defecto.
set VERIFYTA="C:\Program Files\UPPAAL-5.0.0\app\bin\verifyta.exe"
cd /d %~dp0
%VERIFYTA% -q -u alerta_uv.xml > salida_verifyta.txt
echo === Mutante M1: umbral 7 en lugar de 8 >  salida_mutantes.txt
%VERIFYTA% -q mutantes\m1_umbral_7.xml >> salida_mutantes.txt
echo === Mutante M2: descarta lecturas extremas >> salida_mutantes.txt
%VERIFYTA% -q mutantes\m2_omision.xml >> salida_mutantes.txt
type salida_verifyta.txt
