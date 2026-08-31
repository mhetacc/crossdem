#let mc(content) = text(font: "Source Code Pro", size: 7pt, content)
#import "@preview/codelst:2.0.2": sourcecode


== Tables

=== Single Table


#v(1.5em)
#figure(
  table(
    columns: (1fr, 1.2fr, 1fr, 1fr, 0.9fr, 1fr),
    align: (horizon, horizon, horizon, horizon, horizon, horizon),
    stroke: 0.5pt,
    inset: 5pt,
    
    // Header row
    table.header(
      [*_Protocol_*],
      [*_Frequency Band_*],
      [*_Range_*],
      [*_Data Rate_*],
      [*_Power Consumption_*],
      [*_Encryption_*]
    ),
    
    // BLE
    [*Bluetooth Low Energy (BLE)*],
    [2.4 GHz ISM],
    [100m (v4.2) \ 200m (v5.0)],
    [Up to 2 Mbps (v5.0)],
    [Very Low],
    [128-bit AES-CCM],
    
    // ZigBee
    [*ZigBee*],
    [2.4 GHz (Global) \ 868 MHz (EU) \ 915 MHz (US)],
    [Up to 100m],
    [20-250 kbps],
    [Very Low],
    [128-bit AES],
    
    // LoRa/LoRaWAN
    [*LoRa/ \ LoRaWAN*],
    [Sub-GHz ISM bands],
    [~5 km (urban) \ ~15 km (rural)],
    [0.3-50 kbps (typical)],
    [Very Low],
    [128-bit AES],
    
    // NB-IoT
    [*NB-IoT*],
    [Licensed LTE bands \ (180 kHz bandwidth)],
    [~1 km (urban) \ ~10 km (rural)],
    [127 kbps (downlink) \ 159 kbps (uplink)],
    [Low],
    [LTE security \ mechanisms],
    
    // 6LoWPAN
    [*6LoWPAN & RPL*],
    [2.4 GHz (Global) \ 915 MHz (US) \ 868 MHz (EU)],
    [Up to 100m],
    [Up to 250 kbps],
    [Very Low],
    [AES-CCM \ (802.15.4 MAC)]
  ),
  caption: [Comparison of IoT wireless communication protocols]
) <tab:tabone>
#v(1.5em)

Another single table.

#v(1em)
#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    align: (center, left, left, left),
    stroke: 0.5pt,
    inset: 5pt,
    [*Level*], [*Field*], [*Description*], [*Example*],
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
  ),
  caption: [10-level topic hierarchy structure]
) <tab:tabtwo>
#v(1em)


=== Stacked Tables

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
        table.header(
          [*time*], [*device\_id*], [*tenant\_id*], [*type*], [*data (JSONB)*],
        ),
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
        table.header(
          [*time*], [*device\_id*], [*tenant\_id*], [*type*], [*data (JSONB)*],
        ),
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
    #figure(image("images/iot-layers.png", width: 7.5cm), 
    caption: "Architecture of IoT (A: 3-layers) (B: 5-layers)")
    <fig:figone>
]

=== Double Figures

#align(bottom)[
   #figure(
    grid(
    columns: (1fr, 1fr), // Divide width into two equal columns
    gutter: 5pt, 
    image("images/req-resp.png", width: 100%),       // Space between figures
    image("images/pub-sub.png", width: 110%),
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

