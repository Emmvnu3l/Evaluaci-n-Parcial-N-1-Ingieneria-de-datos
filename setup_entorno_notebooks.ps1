# Instalador PowerShell para entorno de notebooks
# Uso: powershell -ExecutionPolicy Bypass -File .\setup_entorno_notebooks.ps1

$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

Write-Host "[1/5] Verificando Python launcher (py)..."
if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
    throw "No se encontro el comando 'py'. Instala Python 3.12 desde https://www.python.org/downloads/"
}

Write-Host "[2/5] Buscando Python compatible (3.12 o 3.11)..."
$pyVersionArg = $null
try {
    & py -3.12 --version *> $null
    $pyVersionArg = '-3.12'
}
catch {
}

if (-not $pyVersionArg) {
    try {
        & py -3.11 --version *> $null
        $pyVersionArg = '-3.11'
    }
    catch {
    }
}

if (-not $pyVersionArg) {
    throw "No se encontro Python 3.12 ni 3.11. Instala Python 3.12 desde https://www.python.org/downloads/ y vuelve a ejecutar este instalador."
}

Write-Host "Se usara: py $pyVersionArg"

if (Test-Path ".venv") {
    Write-Host "Eliminando .venv anterior para evitar conflictos..."
    Remove-Item ".venv" -Recurse -Force
}

Write-Host "Creando entorno virtual (.venv)..."
& py $pyVersionArg -m venv .venv
if (-not (Test-Path ".venv\Scripts\python.exe")) {
    throw "No se pudo crear el entorno virtual."
}

Write-Host "[3/5] Actualizando pip, setuptools y wheel..."
& .\.venv\Scripts\python.exe -m pip install --upgrade pip setuptools wheel

Write-Host "[4/5] Instalando dependencias de notebooks..."
& .\.venv\Scripts\python.exe -m pip install -r requirements-notebooks.txt

Write-Host "[5/5] Registrando kernel de Jupyter..."
& .\.venv\Scripts\python.exe -m ipykernel install --user --name evparcial1-venv --display-name "Python (EV Parcial 1)"

Write-Host ""
Write-Host "Instalacion finalizada correctamente."
Write-Host "Para usar el entorno:"
Write-Host "  .\.venv\Scripts\Activate.ps1"
Write-Host "  jupyter lab"
