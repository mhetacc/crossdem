#let mc(content) = text(font: "Source Code Pro", size: 7pt, content)
#import "@preview/codelst:2.0.2": sourcecode


== Tables

=== Not Colored

#v(1em)
#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    align: (center, left, left, left),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Level*], [*Field*], [*Description*], [*Example*],
    table.hline(stroke: 0.5pt),
    [1], [`tenant_id`], [Logical isolation between organizations], [`agroTech01`],
    [2], [`site_type`], [Type of agricultural facility], [`greenhouse`, `open field`],
    [3], [`site_id`], [Physical site identifier], [`GH-001`],
    [4], [`section_id`], [Section within the site], [`section-2`],
    [5], [`zone_id`], [Operational zone], [`zone-A`],
    [6], [`entity_type`], [Device category], [`sensor`, `actuator`],
    [7], [`entity_subclass`], [Specific device type], [`temp`, `ph`, `water pump`],
    [8], [`entity_id`], [Unique device identifier], [`mqtt-device-03`],
    [9], [`message_type`], [Message classification], [`data`, `cmd`, `status`, `alert`],
    [10], [`target_id`], [Target device for commands (optional)], [`cooler-001`],
    table.hline(stroke: 1pt),
  ),
  caption: [10-level topic hierarchy structure]
) <tab:tabtwo>
#v(1em)

=== Colored

#v(1em)
#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    align: (center, left, left, left),
    stroke: none,
    inset: 5pt,
    fill: (col, row) => {
      if row == 0 { rgb("#B5001B") }
      else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
      else { white }
    },
    table.hline(stroke: 1pt),
    text(fill:white)[*Level*], text(fill:white)[*Field*], text(fill:white)[*Description*], text(fill:white)[*Example*],
    table.hline(stroke: 0.5pt),
    [1], [`tenant_id`], [Logical isolation between organizations], [`agroTech01`],
    [2], [`site_type`], [Type of agricultural facility], [`greenhouse`, `open field`],
    [3], [`site_id`], [Physical site identifier], [`GH-001`],
    [4], [`section_id`], [Section within the site], [`section-2`],
    [5], [`zone_id`], [Operational zone], [`zone-A`],
    [6], [`entity_type`], [Device category], [`sensor`, `actuator`],
    [7], [`entity_subclass`], [Specific device type], [`temp`, `ph`, `water pump`],
    [8], [`entity_id`], [Unique device identifier], [`mqtt-device-03`],
    [9], [`message_type`], [Message classification], [`data`, `cmd`, `status`, `alert`],
    [10], [`target_id`], [Target device for commands (optional)], [`cooler-001`],
    table.hline(stroke: 1pt),
  ),
  caption: [10-level topic hierarchy structure]
) <tab:tabtwo>
#v(1em)

=== Half Colored Half Not


#v(1em)
#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    align: (center, left, left, left),
    stroke: none,
    inset: 5pt,
    fill: (col, row) => {
      if row == 0 { rgb("#FFFFFF") }
      else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
      else { white }
    },
    table.hline(stroke: 1pt),
    [*Level*], [*Field*], [*Description*], [*Example*],
    table.hline(stroke: 0.5pt),
    [1], [`tenant_id`], [Logical isolation between organizations], [`agroTech01`],
    [2], [`site_type`], [Type of agricultural facility], [`greenhouse`, `open field`],
    [3], [`site_id`], [Physical site identifier], [`GH-001`],
    [4], [`section_id`], [Section within the site], [`section-2`],
    [5], [`zone_id`], [Operational zone], [`zone-A`],
    [6], [`entity_type`], [Device category], [`sensor`, `actuator`],
    [7], [`entity_subclass`], [Specific device type], [`temp`, `ph`, `water pump`],
    [8], [`entity_id`], [Unique device identifier], [`mqtt-device-03`],
    [9], [`message_type`], [Message classification], [`data`, `cmd`, `status`, `alert`],
    [10], [`target_id`], [Target device for commands (optional)], [`cooler-001`],
    table.hline(stroke: 1pt),
  ),
  caption: [10-level topic hierarchy structure]
) <tab:tabtwo>
#v(1em)


=== Stacked


#figure(
  caption: [Sample rows from `iot_records_tenant_01` (top) and `iot_records_tenant_02` (bottom).],
  grid(
    columns: 1,
    row-gutter: 1em,

    [
      _Table iot\_records\_tenant\_01_
      #table(
        columns: (auto, auto, auto, auto, auto),
        align: (left, left, center, center, left),
        inset: (x: 3pt, y: 7pt),
        stroke: none,
        fill: (col, row) => {
          if row == 0 { rgb("#B5001B") }
          else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
          else { white }
        },
        table.header(
          text(fill:white)[*Time*], text(fill:white)[*Device ID*], text(fill:white)[*Tenant ID*], text(fill:white)[*Type*], text(fill:white)[*Data (JSONB)*],
        ),
        table.hline(stroke: 0.5pt),
        mc[2025-11-10 08:03:12 UTC], mc[temp\_001], mc[tenant\_01], mc[data],   mc[{"value": 22.4, "unit": "C"}],
        mc[2025-11-10 08:05:44 UTC], mc[fan\_003],  mc[tenant\_01], mc[status], mc[{"running": true, "speed": "medium"}],
        mc[2025-11-10 08:07:01 UTC], mc[temp\_001], mc[tenant\_01], mc[alert],  mc[{"code": "OVER_THRESHOLD", "value": 29.1}],
        mc[2025-11-10 08:09:33 UTC], mc[fan\_003],  mc[tenant\_01], mc[cmd],    mc[{"action": "set_speed", "target": "high"}],
      )
    ],

    [
      _Table iot\_records\_tenant\_02_
      #table(
        columns: (auto, auto, auto, auto, auto),
        align: (left, left, center, center, left),
        inset: (x: 3pt, y: 7pt),
        stroke: none,
        fill: (col, row) => {
          if row == 0 { rgb("#B5001B") }
          else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
          else { white }
        },
        table.header(
          text(fill:white)[*Time*], text(fill:white)[*Device ID*], text(fill:white)[*Tenant ID*], text(fill:white)[*Type*], text(fill:white)[*Data (JSONB)*],
        ),
        table.hline(stroke: 0.5pt),
        mc[2025-11-10 08:10:22 UTC], mc[temp\_007], mc[tenant\_02], mc[data],   mc[{"value": 18.9, "unit": "C"}],
        mc[2025-11-10 08:10:25 UTC], mc[air\_008],  mc[tenant\_02], mc[data],   mc[{"value": 412, "unit": "ppm"}],
        mc[2025-11-10 08:12:01 UTC], mc[temp\_007], mc[tenant\_02], mc[status], mc[{"online": true, "battery": 87}],
      )
    ],
  )
) <tab:tabthree>
#v(1em)


== Figures

`#align()` without any arguments defaults to _center_.

=== Single Figure

#v(0.5em)
#align(center)[
    #figure(image("images/italian_prime_ministers.jpg", width: 7.5cm), 
    caption: "Architecture of IoT (A: 3-layers) (B: 5-layers)")
    <fig:figone>
]

=== Double Figures

#align()[
   #figure(
    grid(
    columns: (1fr, 1fr), // Divide width into two equal columns
    gutter: 5pt, 
    image("images/italian_prime_ministers.jpg", width: 50%),       // Space between figures
    image("images/italian_prime_ministers.jpg", width: 110%),
  ),
  caption: [Comparison between (a) Request-Response and (b) Publish-Subscribe paradigms ]
)
    <fig:figtwo>
]
#v(1em)

== Code Listings

#figure(
  sourcecode(
  ```json
    { 
      "entity": { "type": "tenant", "id": "agroTech01" },
      "relation": "admin",
      "subject": { "type": "user", "id": "john_doe" }
    }
  ``` 
), caption: "Example of a Permify tuple"
) <code:codeone>


#figure(
  sourcecode(
  ```python
    def extract_page_date(soup: BeautifulSoup) -> tuple[date | None, str]:
        """Page-level event date (meta > title > stamp > sommario prose)."""
        for attr, val in [("name", "dcterms.date"), ("property", "article:published_time")]:
            tag = soup.find("meta", {attr: val})
            if tag and tag.get("content"):
                d = _try_iso(tag["content"])
                if d: return d, "meta_tag"
    
        title = soup.find("title")
        if title:
            d = _try_dotted(title.get_text())
            if d: return d, "page_title"
    
        page_text = soup.get_text(" ", strip=True)
        d = _try_short(page_text)
        if d: return d, "page_stamp"
    
        d = _try_long(page_text)
        if d: return d, "page_sommario"
    
        return None, "not_found"
  ``` 
), caption: "Example of a Permify tuple"
) <code:codetwo>

