SET THIS_DIR=%~d0%~p0

if "%PLDOC_OUTPUT%" == "" ( echo WARN: Environment variable PLDOC_OUTPUT not set.  Creating output in %%TEMP%% 1>&2 && PAUSE && SET PLDOC_OUTPUT=%TEMP%)


echo "%THIS_DIR%"\pldoc.bat -doctitle 'PLDoc Drag and Drop Output' -d "%PLDOC_OUTPUT%" %*
call "%THIS_DIR%"\pldoc.bat -doctitle 'PLDoc Drag and Drop Output' -d "%PLDOC_OUTPUT%" %*

start %PLDOC_OUTPUT%\index.html 
