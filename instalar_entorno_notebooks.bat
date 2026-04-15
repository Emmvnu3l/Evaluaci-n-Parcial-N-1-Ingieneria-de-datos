@echo off
setlocal enabledelayedexpansion

REM ------------------------------------------------------------
REM Instalador automatico de entorno Python para notebooks
REM Crea .venv, instala dependencias y registra kernel Jupyter
REM ------------------------------------------------------------

cd /d "%~dp0"

echo [1/5] Verificando Python launcher (py)...
where py >nul 2>nul
if errorlevel 1 (
    echo ERROR: No se encontro el comando 'py'.
    echo Instala Python 3.12 desde https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [2/5] Buscando Python compatible (3.12 o 3.11)...
set "PYCMD="
py -3.12 --version >nul 2>nul && set "PYCMD=py -3.12"
if not defined PYCMD (
    py -3.11 --version >nul 2>nul && set "PYCMD=py -3.11"
)
if not defined PYCMD (
    echo ERROR: No se encontro Python 3.12 ni 3.11.
    echo Instala Python 3.12 desde https://www.python.org/downloads/ y vuelve a ejecutar este instalador.
    pause
    exit /b 1
)

echo Se usara: !PYCMD!

if exist ".venv" (
    echo Eliminando .venv anterior para evitar conflictos...
    rmdir /s /q ".venv"
)

echo Creando entorno virtual (.venv)...
!PYCMD! -m venv .venv
if errorlevel 1 (
    echo ERROR: No se pudo crear el entorno virtual.
    pause
    exit /b 1
)

echo [3/5] Actualizando pip, setuptools y wheel...
call ".venv\Scripts\activate.bat"
python -m pip install --upgrade pip setuptools wheel
if errorlevel 1 (
    echo ERROR: Fallo la actualizacion de herramientas base de pip.
    pause
    exit /b 1
)

echo [4/5] Instalando dependencias de notebooks...
pip install -r requirements-notebooks.txt
if errorlevel 1 (
    echo ERROR: Fallo la instalacion de dependencias.
    pause
    exit /b 1
)

echo [5/5] Registrando kernel de Jupyter...
python -m ipykernel install --user --name evparcial1-venv --display-name "Python (EV Parcial 1)"
if errorlevel 1 (
    echo ADVERTENCIA: No se pudo registrar el kernel. El entorno igual fue creado.
)

echo.
echo Instalacion finalizada correctamente.
echo Para abrir JupyterLab en este entorno:
echo   .venv\Scripts\activate
echo   jupyter lab
echo.
pause
