"""Dibuja las plantillas de alerta_uv.xml con el estilo del editor de UPPAAL.

Lee las ubicaciones, aristas, clavos (nails) y etiquetas con sus coordenadas
del propio modelo, de modo que la figura es exactamente el autómata verificado.

Uso:  python dibujar_automatas.py   ->  ../docs/figuras/uppaal_<plantilla>.png
"""
from pathlib import Path
import math
import xml.etree.ElementTree as ET

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch

AQUI = Path(__file__).resolve().parent
SALIDA = AQUI.parent / "docs" / "figuras"
R = 13  # radio de una ubicación (como en UPPAAL)

COLOR = {
    "name": "#8b0000",          # nombre de ubicación
    "invariant": "#8b008b",     # invariante
    "select": "#b8860b",        # select
    "guard": "#007a00",         # guarda
    "synchronisation": "#00838f",  # canal
    "assignment": "#0000b3",    # actualización
}


def recortar(p, q, r=R):
    """Mueve p hacia q una distancia r (para que la flecha toque el borde del círculo)."""
    dx, dy = q[0] - p[0], q[1] - p[1]
    d = math.hypot(dx, dy) or 1
    return (p[0] + dx / d * r, p[1] + dy / d * r)


def dibujar(tpl, destino):
    locs = {}
    for loc in tpl.findall("location"):
        nombre = loc.find("name")
        locs[loc.get("id")] = {
            "xy": (float(loc.get("x")), float(loc.get("y"))),
            "nombre": nombre.text if nombre is not None else "",
            "nxy": (float(nombre.get("x")), float(nombre.get("y"))) if nombre is not None else None,
            "committed": loc.find("committed") is not None,
            "labels": [(l.get("kind"), l.text, float(l.get("x")), float(l.get("y")))
                       for l in loc.findall("label")],
        }
    init = tpl.find("init").get("ref")

    xs, ys = [], []
    fig, ax = plt.subplots()

    for tr in tpl.findall("transition"):
        s, t = tr.find("source").get("ref"), tr.find("target").get("ref")
        puntos = [locs[s]["xy"]] + [(float(n.get("x")), float(n.get("y"))) for n in tr.findall("nail")] + [locs[t]["xy"]]
        puntos[0] = recortar(puntos[0], puntos[1])
        puntos[-1] = recortar(puntos[-1], puntos[-2])
        for a, b in zip(puntos[:-2], puntos[1:-1]):
            ax.plot([a[0], b[0]], [a[1], b[1]], color="black", lw=1.1, zorder=1)
        ax.add_patch(FancyArrowPatch(puntos[-2], puntos[-1], arrowstyle="-|>", mutation_scale=11,
                                     color="black", lw=1.1, zorder=1, shrinkA=0, shrinkB=0))
        xs += [p[0] for p in puntos]
        ys += [p[1] for p in puntos]
        for l in tr.findall("label"):
            x, y = float(l.get("x")), float(l.get("y"))
            ax.text(x, y, l.text, color=COLOR[l.get("kind")], fontsize=8.5, va="top", ha="left",
                    family="DejaVu Sans Mono", zorder=3)
            xs.append(x + 7 * max(len(s) for s in l.text.splitlines()))
            ys.append(y + 14 * len(l.text.splitlines()))
            xs.append(x)
            ys.append(y)

    for lid, d in locs.items():
        x, y = d["xy"]
        ax.add_patch(Circle((x, y), R, facecolor="#e8eef7", edgecolor="black", lw=1.2, zorder=2))
        if lid == init:
            ax.add_patch(Circle((x, y), R - 4, facecolor="none", edgecolor="black", lw=1.0, zorder=2))
        if d["committed"]:
            ax.text(x, y, "C", ha="center", va="center", fontsize=8, weight="bold", zorder=3)
        if d["nxy"]:
            ax.text(*d["nxy"], d["nombre"], color=COLOR["name"], fontsize=9.5, weight="bold",
                    va="top", ha="left", zorder=3)
            xs.append(d["nxy"][0] + 8 * len(d["nombre"]))
            ys.append(d["nxy"][1])
        for kind, texto, lx, ly in d["labels"]:
            ax.text(lx, ly, texto, color=COLOR[kind], fontsize=8.5, va="top", ha="left",
                    family="DejaVu Sans Mono", zorder=3)
            xs += [lx + 7 * len(texto)]
            ys += [ly + 14]
        xs += [x - R, x + R]
        ys += [y - R, y + R]

    m = 15
    ax.set_xlim(min(xs) - m, max(xs) + m)
    ax.set_ylim(max(ys) + m, min(ys) - m)  # el eje y de UPPAAL crece hacia abajo
    ax.set_aspect("equal")
    ax.axis("off")
    ancho = (max(xs) - min(xs) + 2 * m) / 95
    alto = (max(ys) - min(ys) + 2 * m) / 95
    fig.set_size_inches(ancho, alto)
    fig.savefig(destino, dpi=300, bbox_inches="tight", pad_inches=0.05, facecolor="white")
    plt.close(fig)
    print("->", destino.relative_to(AQUI.parent))


def main():
    raiz = ET.parse(AQUI / "alerta_uv.xml").getroot()
    SALIDA.mkdir(exist_ok=True)
    for tpl in raiz.findall("template"):
        nombre = tpl.find("name").text.lower()
        dibujar(tpl, SALIDA / f"uppaal_{nombre}.png")


if __name__ == "__main__":
    main()
