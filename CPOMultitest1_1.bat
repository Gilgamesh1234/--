ECHO OFF

CD C:\cpo

for %%i in (C:\Users\CPO\Desktop\2016_Juho\CPOinput\CPOinput*.dat) do (
PING 1.1.1.1 -n 1 -w 1000 >NUL
start CPO3d %%i
)

echo cpos are executed

:test
tasklist /FI "IMAGENAME eq CPO3D.exe" /NH | find /I /N "CPO3D.exe" >NUL

if "%ERRORLEVEL%"=="0" (echo program is running
PING 1.1.1.1 -n 1 -w 1000 >NUL
goto test
) else (
echo Done
exit
)
