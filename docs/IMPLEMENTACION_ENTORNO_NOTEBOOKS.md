# Implementacion de entorno Python para archivos .ipynb y flujo tipo Colab

Este documento define una implementacion completa para trabajar con notebooks de Jupyter (.ipynb) y con practicas compatibles con Google Colab.

## 1) Objetivo

Crear un entorno reproducible en Windows para:
- Analisis de datos (pandas, numpy, scipy)
- Visualizacion (matplotlib, seaborn, plotly)
- Modelado basico de ML (scikit-learn, statsmodels)
- Trabajo interactivo en notebooks (ipykernel y utilidades base)

## 1.1) Version de Python recomendada

Este proyecto debe ejecutarse con **Python 3.12** o **Python 3.11**.

No se recomienda usar Python 3.14 para este entorno porque puede generar errores al importar paquetes compilados como pandas.

## 2) Archivos incluidos

- `requirements-notebooks.txt`: lista de dependencias base recomendadas.
- `instalar_entorno_notebooks.bat`: ejecutable para instalar todo automaticamente.
- `setup_entorno_notebooks.ps1`: alternativa en PowerShell.

## 3) Instalacion rapida (recomendada)

1. Haz doble clic en `instalar_entorno_notebooks.bat`
2. Espera a que termine la instalacion.
3. Abre VS Code o terminal y activa el entorno:

```powershell
.\.venv\Scripts\Activate.ps1
```

4. Levanta JupyterLab:

```powershell
jupyter lab
```

## 4) Uso del kernel en notebooks

Cuando abras un .ipynb, selecciona el kernel:
- **Python (EV Parcial 1)**

Ese kernel queda registrado por el instalador para evitar elegir el interprete manualmente en cada notebook.

## 5) Flujo compatible con Google Colab

Para mantener compatibilidad con Colab:
- Usa rutas relativas para datos cuando sea posible.
- Evita dependencias de sistema operativo.
- Si llevas el notebook a Colab, instala paquetes faltantes con:

```python
!pip install -q pandas numpy scipy scikit-learn matplotlib seaborn plotly
```

## 5.1) Extras opcionales

Si quieres interfaz completa de JupyterLab o widgets avanzados, instala manualmente después del entorno base:

```powershell
pip install jupyterlab notebook ipywidgets jupyterlab-widgets nbconvert
```

## 6) Mantenimiento del entorno

Actualizar paquetes:

```powershell
.\.venv\Scripts\Activate.ps1
pip install --upgrade -r requirements-notebooks.txt
```

## 7) Solucion de problemas comunes

- Error "py no reconocido": reinstalar Python y marcar "Add python.exe to PATH".
- Error de politicas de PowerShell: ejecutar con `-ExecutionPolicy Bypass`.
- Si no aparece el kernel en VS Code: correr nuevamente el instalador o ejecutar:

```powershell
.\.venv\Scripts\python.exe -m ipykernel install --user --name evparcial1-venv --display-name "Python (EV Parcial 1)"
```

## 8) Estructura recomendada del proyecto

- `data/`: datos crudos y procesados
- `notebooks/`: notebooks de analisis
- `src/`: funciones reutilizables
- `outputs/`: graficos, tablas y resultados exportados
- `docs/`: guias y documentacion

Con esta implementacion tienes un entorno completo y reproducible para desarrollo en notebooks, con instalacion automatizada en un solo ejecutable.
