# Dispositivo IoT de alerta temprana de radiación UV: VDM++ y UPPAAL

Proyecto del curso **Aspectos Formales de Especificación y Verificación**, Escuela Profesional de Ingeniería de Sistemas, Universidad Nacional de San Agustín de Arequipa, 2026. Grupo 6.

**Integrantes:** Mamani Anahua Victor Narciso · Maldonado Vilca Victor Gonzalo · Mamani Céspedes Jhonatan Benjamin · Quispe Marca Edysson Darwin
**Docente:** Mg. Maribel Molina Barriga

En Arequipa el índice UV llega a la categoría «extremo» casi a diario en verano. Este proyecto especifica la regla de alerta de un dispositivo IoT, que mide el índice y alerta cuando llega a 8 o más, para que por diseño cumpla dos cosas:

- **Seguridad:** nunca emite una alerta sin una lectura válida que la justifique.
- **Vivacidad:** toda lectura de riesgo termina en una alerta, emitida dentro de un plazo.

| Parte | Herramienta | Resultado |
|---|---|---|
| 1. Especificación y validación | VDM++ con VDMJ 4.7.0 | 16 casos de prueba (8 de éxito y 8 de fallo), todos con el resultado esperado; 100 % de cobertura |
| 2. Model checking | UPPAAL 5.0 | 11 propiedades (`A[]`, `E<>`, `E[]`, `-->`) verificadas sobre 50 843 estados; 2 mutantes detectados |

## Estructura

```
├── vdmpp/          Parte 1: especificación formal en VDM++
│   ├── Tipos.vdmpp, DispositivoUV.vdmpp, CentralMonitoreo.vdmpp
│   ├── PruebasAlertaUV.vdmpp        16 casos de prueba (CP01 a CP16)
│   ├── pruebas_exito.bat, pruebas_fallo.bat, cobertura.bat
│   └── salidas/                     salida obtenida en VDMJ
├── uppaal/         Parte 2: model checking (tiene su propio README)
│   ├── alerta_uv.xml                red de autómatas y las 11 consultas
│   ├── propiedades.q, verificar.bat, salida_*.txt
│   └── mutantes/                    modelos con errores y sus contraejemplos
└── docs/
    ├── Articulo_IEEE_Alerta_UV_Grupo06.pdf
    └── figuras/                     diagramas UML y autómatas
```

## Requisitos

- **Java 11 o superior.**
- **VDMJ 4.7.0.** Viene con la extensión *VDM VSCode* de Overture (`overturetool.vdm-vscode`). Los `.bat` lo buscan en la carpeta de esa extensión; si está en otra ruta, defina antes la variable `VDMJ`:
  `set VDMJ=C:\ruta\vdmj-4.7.0.jar`
- **UPPAAL 5.0** (licencia académica gratuita en [uppaal.org](https://uppaal.org)). `verificar.bat` usa la ruta por defecto `C:\Program Files\UPPAAL-5.0.0`.

## Orientación rápida

**Parte 1: VDM++**

```bat
cd vdmpp
pruebas_exito.bat    :: CP01 a CP08: cada caso devuelve su valor esperado
pruebas_fallo.bat    :: CP09 a CP16: cada caso se detiene en el invariante o la precondición esperada
cobertura.bat        :: los 16 casos y la cobertura por clase (100 %)
```

El modelo también se puede abrir en VS Code con la extensión VDM VSCode. Las clases principales son:

- `Tipos`: lecturas y alertas como registros con invariante. Una alerta falsa no se puede construir.
- `DispositivoUV`: sensores e historial ordenado de lecturas.
- `CentralMonitoreo`: dispositivos y alertas. `RecibirLectura` crea una alerta por cada lectura de riesgo.

**Parte 2: UPPAAL**

```bat
cd uppaal
verificar.bat        :: verifica las 11 propiedades y los 2 mutantes
```

También se puede abrir `uppaal/alerta_uv.xml` en UPPAAL e ir a la pestaña **Verifier** → **Check**. Se espera que 10 propiedades salgan en verde y **P10 en rojo**: P10 afirma que existe una alerta originada por una lectura fuera de rango, y esa alerta no es alcanzable. El detalle de cada propiedad está en [uppaal/README.md](uppaal/README.md).

## Requerimientos funcionales

| RF | Descripción |
|---|---|
| RF1 | Registrar dispositivos con identificador único |
| RF2 | Cada dispositivo tiene al menos un sensor |
| RF3 | El estado de una lectura es coherente con su índice (0 a 20 si es operativa) |
| RF4 | Registrar lecturas de sensores propios en orden de instante |
| RF5 | Clasificar el índice en los cinco niveles de la OMS |
| RF6 | No emitir alertas falsas: solo lecturas operativas con índice ≥ 8 |
| RF7 | No omitir alertas: toda lectura de riesgo genera su alerta |
| RF8 | Ciclo de la alerta: Pendiente → Emitida → Atendida |

## Enlaces

- Artículo: [docs/Articulo_IEEE_Alerta_UV_Grupo06.pdf](docs/Articulo_IEEE_Alerta_UV_Grupo06.pdf)
- Video de presentación: [carpeta de Google Drive](https://drive.google.com/drive/folders/1vr3s796qSmJb97FL0z5ge5k5AGx-0rbo?usp=sharing)
- Repositorio: https://github.com/Victor-Gonzalo-Maldonado-Vilca/alerta-uv-vdmpp-uppaal
