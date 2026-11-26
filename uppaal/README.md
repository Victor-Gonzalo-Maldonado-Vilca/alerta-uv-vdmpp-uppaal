# Model Checking en UPPAAL: alerta temprana de radiación UV

Grupo 6 · Aspectos Formales de Especificación y Verificación · UNSA 2026

Red de autómatas temporizados derivada del modelo VDM++ (`../vdmpp/`).
Modela la recepción de una lectura UV en la central y el ciclo de vida
de la alerta que genera.

| Autómata | Equivale en VDM++ a | Qué hace |
|---|---|---|
| `Sensor` | lecturas de `DispositivoUV` | Cada `PERIODO` elige un índice (−1, 0, 7, 8, 11, 20, 21) con o sin señal y lo envía por `leer` |
| `Central` | `CentralMonitoreo.RecibirLectura` | Clasifica la lectura (operativo, fueraDeRango, sinLectura) y, si `indice >= 8`, crea la alerta por `crear[i]` |
| `Alerta(id)` | `Tipos.EstadoAlerta` | `Pendiente → Emitida → Atendida`; debe emitirse en `T_EMITIR` unidades |

## Archivos

- `alerta_uv.xml`: el modelo con las 11 consultas (se abre en UPPAAL 5.0).
- `propiedades.q`: las mismas consultas en texto plano, con su comentario.
- `verificar.bat`: corre `verifyta` sobre el modelo y los mutantes.
- `salida_verifyta.txt` y `salida_mutantes.txt`: la salida obtenida.
- `mutantes/`: dos modelos con errores a propósito (umbral 7; lecturas ≥ 11 descartadas), con sus contraejemplos (`.xtr` para el simulador y `.txt` legibles).
- `dibujar_automatas.py`: genera las figuras del artículo (`../docs/figuras/uppaal_*.png`) a partir del XML.

## Cómo usarlo

1. Abrir `alerta_uv.xml` en UPPAAL 5.0: **Editor** para ver los autómatas, **Verifier** → *Check* para las 11 propiedades.
2. Desde la consola, ejecutar `verificar.bat`. Se espera que 10 propiedades se cumplan y que **P10 no se cumpla**, porque afirma que existe una alerta originada por una lectura fuera de rango y esa alerta no es alcanzable.

## Propiedades

| Id | Consulta (resumida) | Requerimiento |
|---|---|---|
| P1 | `A[] Central.operativo imply 0 <= lec_indice <= 20` | RF3 |
| P2 | `A[]` toda alerta viene de una lectura Operativo `>= 8` con el nivel correcto | RF5, RF6 |
| P3 | `A[]` toda lectura de riesgo registrada tiene alerta | RF7 |
| P4 | `A[] Atendida imply emitida` | RF8 |
| P5 | `A[] Pendiente imply x <= T_EMITIR` | RF8 |
| P6 | `A[] deadlock imply` todo procesado y sin alertas a medias | — |
| P7 | `E<> Alerta(0).Atendida` | RF8 |
| P8 | `E<> total == N_ALERTAS` | RF7 |
| P9 | `E[]` nunca se crea una alerta | RF6 |
| P10 | `E<>` alerta por lectura fuera de rango (**debe ser falsa**) | RF6 |
| P11 | `Alerta(0).Pendiente --> Alerta(0).Emitida` | RF8 |

Espacio de estados: 50 843 estados simbólicos; cada consulta tarda menos de 0.2 s.
