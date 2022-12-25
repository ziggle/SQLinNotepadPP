<# : tracer.cmd
:: Launches file selectors and passes the results on to tracer for use in performing a completeness analysis

@echo off
setlocal ENABLEDELAYEDEXPANSION
Title tracer
set "version=0.5"

@REM Give the user a bit of info on what's going to happen
echo Version: %version%&echo,
echo This program is designed to analyze the completeness of work item linkages
echo between items stored in 2 or more files. These files are expected to have
echo been exported from Polarion using the ^"Coverage^" template available under
echo the ^"xlsx: Microsoft Excel^" format. This program will convert any .xlsx
echo file selected by the user into .csv format before analysis. To save time, this
echo program can be directed to the .csv files directly on subsequent runs.&echo,

@REM Get cmd file directory for output & calling tracer.exe
FOR %%Q IN ("%~dp0\.") DO set "out_dir="%%~fQ\output""
IF not exist %out_dir% mkdir %out_dir%
set "python_path=python"
set "tracer_path=tracer.py"

@REM Setup virtual environment
echo Setting up virtual environment
IF exist .\.venv (
    echo Previous virtual environment detected, skipping setup
    CALL .\.venv\Scripts\activate.bat
) ELSE (
    CALL %python_path% -m venv .venv --system-site-packages
    CALL .\.venv\Scripts\activate.bat
    echo Installing dependencies
    CALL pip install -r requirements.txt
    echo Environment setup complete
)

@REM Run through and grab all the files for parent and child
echo Select parent file(s)
echo NOTE: If .xlsx files are selected, program will automatically create .csv copies
FOR /f "delims=" %%I IN ('PowerShell -NoProfile "iex (${%~f0} | out-string)"') DO (
    set "parent_files=!parent_files!"%%I^" "
)
echo Select child file(s)
FOR /f "delims=" %%I IN ('PowerShell -NoProfile "iex (${%~f0} | out-string)"') DO (
    set "child_files=!child_files!"%%I^" "
)

@REM Get the relationship type
echo Select the appropriate analysis type:
set /P "select=For a ^"downward^" analysis (i.e. ^"is refined by^" from Parent to Child) type y, otherwise type n. [y/n]"
IF /I "%select%" EQU "y" (
    set "rel_type="is refined by""
) ELSE (
    set "rel_type="refines""
)

@REM Call tracer with the arguments collected above
CALL %python_path% %tracer_path% -p %parent_files% -c %child_files% -o %out_dir% --relation-type %rel_type%
echo tracer closed

@REM Exit virtual environment
CALL .\.venv\Scripts\deactivate.bat
echo Virtual environment deactivated

@REM Exit script
echo Press any key to exit...
PAUSE>nul
GOTO :EOF

: end Batch section / begin PowerShell section #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
$f.Filter = "Excel Files (*.xlsx*)|*.xlsx*|Comma Separated Values (*.csv)|*.csv"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
IF ($f.Multiselect) { $f.FileNames } ELSE { $f.FileName }