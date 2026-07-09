import datetime

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

import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(12, 8)) # Increased height slightly to fit names better

# Generate a color palette
colors = plt.cm.tab20.colors  

for i, (name, terms) in enumerate(politicians):
    color = colors[i % len(colors)] 

    for start, end in terms:
        ax.barh(i, end - start, left=start, height=0.4, color=color)
        
    # --- METHOD 1: Add Colored Dots ---
    # Using get_yaxis_transform() maps X to the axis scale (0 is the y-axis line) 
    # and Y to the data scale (the politician's row). 
    # -0.015 pushes the dot slightly left of the y-axis.
    ax.scatter(-0.015, i, color=color, transform=ax.get_yaxis_transform(), 
               clip_on=False, s=80, zorder=10)

# Labels
ax.set_yticks(range(len(politicians)))
ax.set_yticklabels([p[0] for p in politicians])
ax.set_xlabel("Year")
ax.set_title("Italian Prime Ministers Timeline")

# Remove the little black y-tick marks so the dots look cleaner next to the text
ax.tick_params(axis='y', length=0, pad=20) 

# --- METHOD 2: Color the Text Directly (Optional) ---
# If you prefer colored text instead of dots, comment out the ax.scatter line above
# and uncomment the three lines below:
# labels = ax.get_yticklabels()
# for i, label in enumerate(labels):
#     label.set_color(colors[i % len(colors)])

plt.tight_layout() # Ensures labels don't get cut off at the edges
plt.savefig("docs/imgs/italian_prime_ministers.jpg", format="jpg", dpi=300, bbox_inches="tight")
#plt.show()