import datetime
import matplotlib.pyplot as plt

politicians = [
    ("Alcide De Gasperi", [
        (datetime.date(1946, 7, 14), datetime.date(1953, 8, 17)),
    ]),
    ("Giuseppe Pella", [
        (datetime.date(1953, 8, 17), datetime.date(1954, 1, 19)),
    ]),
    ("Amintore Fanfani", [
        (datetime.date(1954, 1, 19), datetime.date(1954, 2, 10)),
        (datetime.date(1958, 7, 2), datetime.date(1959, 2, 16)),
        (datetime.date(1960, 7, 27), datetime.date(1963, 7, 22)),
        (datetime.date(1982, 12, 1), datetime.date(1983, 8, 4)),
        (datetime.date(1987, 4, 18), datetime.date(1987, 7, 29)),
    ]),
    ("Mario Scelba", [
        (datetime.date(1954, 2, 10), datetime.date(1955, 7, 6)),
    ]),
    ("Antonio Segni", [
        (datetime.date(1955, 7, 6), datetime.date(1957, 5, 20)),
        (datetime.date(1959, 2, 16), datetime.date(1960, 3, 26)),
    ]),
    ("Adone Zoli", [
        (datetime.date(1957, 5, 20), datetime.date(1958, 7, 2)),
    ]),
    ("Fernando Tambroni", [
        (datetime.date(1960, 3, 26), datetime.date(1960, 7, 27)),
    ]),
    ("Giovanni Leone", [
        (datetime.date(1963, 6, 22), datetime.date(1963, 12, 5)),
        (datetime.date(1968, 6, 25), datetime.date(1968, 12, 13)),
    ]),
    ("Aldo Moro", [
        (datetime.date(1963, 12, 5), datetime.date(1968, 6, 25)),
        (datetime.date(1974, 11, 23), datetime.date(1976, 7, 30)),
    ]),
    ("Mariano Rumor", [
        (datetime.date(1968, 12, 13), datetime.date(1970, 8, 6)),
        (datetime.date(1973, 7, 8), datetime.date(1974, 11, 23)),
    ]),
    ("Emilio Colombo", [
        (datetime.date(1970, 8, 6), datetime.date(1972, 2, 18)),
    ]),
    ("Giulio Andreotti", [
        (datetime.date(1972, 2, 18), datetime.date(1973, 7, 8)),
        (datetime.date(1976, 7, 30), datetime.date(1979, 8, 5)),
        (datetime.date(1989, 7, 23), datetime.date(1992, 6, 28)),
    ]),
    ("Francesco Cossiga", [
        (datetime.date(1979, 8, 5), datetime.date(1980, 10, 18)),
    ]),
    ("Arnaldo Forlani", [
        (datetime.date(1980, 10, 18), datetime.date(1981, 6, 28)),
    ]),
    ("Giovanni Spadolini", [
        (datetime.date(1981, 6, 28), datetime.date(1982, 12, 1)),
    ]),
    ("Bettino Craxi", [
        (datetime.date(1983, 8, 4), datetime.date(1987, 4, 18)),
    ]),
    ("Giovanni Goria", [
        (datetime.date(1987, 7, 29), datetime.date(1988, 4, 13)),
    ]),
    ("Ciriaco De Mita", [
        (datetime.date(1988, 4, 13), datetime.date(1989, 7, 23)),
    ]),
    ("Giuliano Amato", [
        (datetime.date(1992, 6, 28), datetime.date(1993, 4, 29)),
        (datetime.date(2000, 4, 26), datetime.date(2001, 6, 11)),
    ]),
    ("Carlo Azeglio Ciampi", [
        (datetime.date(1993, 4, 29), datetime.date(1994, 5, 11)),
    ]),
    ("Silvio Berlusconi", [
        (datetime.date(1994, 5, 11), datetime.date(1995, 1, 17)),
        (datetime.date(2001, 6, 11), datetime.date(2006, 5, 17)),
        (datetime.date(2008, 5, 8), datetime.date(2011, 11, 16)),
    ]),
    ("Lamberto Dini", [
        (datetime.date(1995, 1, 17), datetime.date(1996, 5, 18)),
    ]),
    ("Romano Prodi", [
        (datetime.date(1996, 5, 18), datetime.date(1998, 10, 21)),
        (datetime.date(2006, 5, 17), datetime.date(2008, 5, 8)),
    ]),
    ("Massimo D'Alema", [
        (datetime.date(1998, 10, 21), datetime.date(2000, 4, 26)),
    ]),
    ("Mario Monti", [
        (datetime.date(2011, 11, 16), datetime.date(2013, 4, 28)),
    ]),
    ("Enrico Letta", [
        (datetime.date(2013, 4, 28), datetime.date(2014, 2, 22)),
    ]),
    ("Matteo Renzi", [
        (datetime.date(2014, 2, 22), datetime.date(2016, 12, 12)),
    ]),
    ("Paolo Gentiloni", [
        (datetime.date(2016, 12, 12), datetime.date(2018, 6, 1)),
    ]),
    ("Giuseppe Conte", [
        (datetime.date(2018, 6, 1), datetime.date(2021, 2, 13)),
    ]),
    ("Mario Draghi", [
        (datetime.date(2021, 2, 13), datetime.date(2022, 10, 22)),
    ]),
    ("Giorgia Meloni", [
        (datetime.date(2022, 10, 22), datetime.datetime.today().date()),  # update if needed
    ]),
]

# Leaning ("C"=center, "L"=left, "R"=right, "CL"/"CR"=center-left/center-right)
# and hex color for each PM, keyed by a short slug.
POL_INFO = {
    "degasperi":  {"leaning": "C",  "color": "#2f4f4f"},  # dark slate grey — PM from 1945
    "fanfani":    {"leaning": "CL", "color": "#e6194B"},  # red — 1954
    #"scelba":     {"leaning": "CR", "color": "#8b4513"},  # saddle brown — 1954 (no data)
    #"segni":      {"leaning": "CR", "color": "#1e90ff"},  # dodger blue — 1955 (no data)
    "leone":      {"leaning": "C",  "color": "#ff4500"},  # orange-red — 1963
    #"moro":       {"leaning": "CL", "color": "#556b2f"},  # dark olive green — 1963 (no data)
    "rumor":      {"leaning": "C",  "color": "#7f0067"},  # deep magenta/plum — 1968
    "colombo":    {"leaning": "C",  "color": "#008080"},  # dark teal — 1970
    "andreotti":  {"leaning": "CR", "color": "#c00000"},  # bright crimson — 1972
    "cossiga":    {"leaning": "CR", "color": "#e6beff"},  # light violet — 1979
    "forlani":    {"leaning": "CR", "color": "#ffe119"},  # yellow — 1980
    "spadolini":  {"leaning": "C",  "color": "#a9a9a9"},  # grey — 1981
    "craxi":      {"leaning": "CL", "color": "#ffd8b1"},  # apricot — 1983
    "goria":      {"leaning": "C",  "color": "#000075"},  # navy — 1987
    "demita":     {"leaning": "CL", "color": "#808000"},  # olive — 1988
    "amato":      {"leaning": "L",  "color": "#aaffc3"},  # mint — 1992
    "ciampi":     {"leaning": "C",  "color": "#9A6324"},  # brown — 1993
    "berlusconi": {"leaning": "R",  "color": "#800000"},  # dark red / maroon — 1994
    "dini":       {"leaning": "CL", "color": "#fabed4"},  # pink — 1995
    "prodi":      {"leaning": "CL", "color": "#469990"},  # teal — 1996
    "dalema":     {"leaning": "L",  "color": "#dcbeff"},  # lavender — 1998
    "monti":      {"leaning": "CR", "color": "#bfef45"},  # lime — 2011
    "letta":      {"leaning": "L",  "color": "#f032e6"},  # magenta — 2013
    "renzi":      {"leaning": "CL", "color": "#42d4f4"},  # cyan — 2014
    "gentiloni":  {"leaning": "CL", "color": "#911eb4"},  # purple — 2016
    "conte":      {"leaning": "CL", "color": "#f58231"},  # orange — 2018
    "draghi":     {"leaning": "C",  "color": "#3cb44b"},  # green — 2021
    "meloni":     {"leaning": "R",  "color": "#4363d8"},  # blue — 2022
}

# Map each full name in `politicians` to its POL_INFO slug.
# Pella, Zoli, and Tambroni have no entry in POL_INFO, so they fall back
# to a neutral grey below.
NAME_TO_SLUG = {
    "Alcide De Gasperi": "degasperi",
    "Amintore Fanfani": "fanfani",
    "Mario Scelba": "scelba",
    "Antonio Segni": "segni",
    "Giovanni Leone": "leone",
    "Aldo Moro": "moro",
    "Mariano Rumor": "rumor",
    "Emilio Colombo": "colombo",
    "Giulio Andreotti": "andreotti",
    "Francesco Cossiga": "cossiga",
    "Arnaldo Forlani": "forlani",
    "Giovanni Spadolini": "spadolini",
    "Bettino Craxi": "craxi",
    "Giovanni Goria": "goria",
    "Ciriaco De Mita": "demita",
    "Giuliano Amato": "amato",
    "Carlo Azeglio Ciampi": "ciampi",
    "Silvio Berlusconi": "berlusconi",
    "Lamberto Dini": "dini",
    "Romano Prodi": "prodi",
    "Massimo D'Alema": "dalema",
    "Mario Monti": "monti",
    "Enrico Letta": "letta",
    "Matteo Renzi": "renzi",
    "Paolo Gentiloni": "gentiloni",
    "Giuseppe Conte": "conte",
    "Mario Draghi": "draghi",
    "Giorgia Meloni": "meloni",
}

FALLBACK_COLOR = "#a9a9a9"  # grey, used for PMs missing from POL_INFO

fig, ax = plt.subplots(figsize=(12, 8))

for i, (name, terms) in enumerate(politicians):
    slug = NAME_TO_SLUG.get(name)
    info = POL_INFO.get(slug) if slug else None
    color = info["color"] if info else FALLBACK_COLOR

    for start, end in terms:
        ax.barh(i, end - start, left=start, height=0.4, color=color)

    # Colored dot next to each name, matching the bar color
    ax.scatter(-0.015, i, color=color, transform=ax.get_yaxis_transform(),
               clip_on=False, s=80, zorder=10)

# Labels
ax.set_yticks(range(len(politicians)))
ax.set_yticklabels([p[0] for p in politicians])
ax.set_xlabel("Year")
ax.set_title("Italian Prime Ministers Timeline")

ax.tick_params(axis='y', length=0, pad=20)

plt.tight_layout()
plt.savefig("report/typst/images/italian_prime_ministers.jpg", format="jpg", dpi=300, bbox_inches="tight")
plt.show()