@rem    Convenience script for quick running of pldoc.
@rem    Make a desktop shortcut of this .bat file, then drag-and-drop a SQL file on it.
@rem    Then pldoc will be run and the result shown in browser.
@rem    Only one SQL file can be dropped.
@rem
@rem    NB: 
@rem    1) pldoc.bat must be in the PATH, or edit this file to add full path before pldoc.bat.
@rem    2) TEMP variable must be defined
@rem    3) there must be a defalt browser defined for running .html files
@rem
@rem    $Id$

REM Resolve the directory of pldoc
set pldir=%~d0%~p0

pushd %TEMP%
call %pldir%cpd.bat -d drop %1%
drop\index.html
PAUSE
