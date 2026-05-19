# BirdWatch_shiny
Housed is the code to reproduce the birdwatch shiny app

## Structure
UI.R is for the interface and contains all the aesthetic elements of the dashboard.
Global.R downloads the cleaned data and sets our color palette.
Server.R runs the app. 
Leaflet_scratch contains additional data cleaning.

```
├── BirdWatch_shiny.Rproj
├── data_raw
│   ├── birds_joined.parquet
│   ├── gap_polygon.parquet
│   └── habitat_polygon.parquet
├── desktop.ini
├── README.md
├── scratch
│   └── leaflet_scratch.R
└── shiny_dashboard
    ├── data
    │   ├── gap_clean.parquet
    │   ├── habitat_clean.parquet
    │   ├── leaflet_bird_points.parquet
    │   └── species.parquet
    ├── global.R
    ├── server.R
    ├── text
    │   ├── citation.md
    │   ├── disclaimer.md
    │   └── intro.md
    ├── ui_scratch.R
    ├── ui.R
    └── www
        ├── BirdWatch_logo.png
        ├── FishCreekWatershedSiteMap_2020.jpg
        └── me_after_presentations.jpg
```
