# BirdWatch Avian Biodiversity Dashboard

An interactive Shiny dashboard exploring avian biodiversity responses to conservation investment across California, built as part of the **Mind the GAP** capstone project at the Bren School of Environmental Science & Management, UCSB.

> **Authors:** Nathalie Bonnet, Isabella Segarra, Peter Vitale\
> **Advisor:** Dr. Naomi Tague \| **Client:** Dr. Sam Veloz, Point Blue Conservation Science\
> **Instructor:** Dr. Carmen Galaz Garcia

------------------------------------------------------------------------

## Quickstart

``` r
# Install dependencies
install.packages(c(
  "shiny", "shinydashboard", "tidyverse", "arrow", "leaflet",
  "leaflet.extras", "leafem", "sf", "shinycssloaders", "markdown",
  "fresh", "sfarrow", "shinyWidgets", "collapsibleTree"
))

# Run the app
shiny::runApp("shiny_dashboard")
```

------------------------------------------------------------------------

## Repository Structure

```         
├── BirdWatch_shiny.Rproj
├── README.md
├── data_raw/                        # Raw inputs before cleaning
│   ├── birds_joined.parquet         # Bird observations joined to spatial layers
│   ├── gap_polygon.parquet          # USGS GAP status polygons (raw)
│   └── habitat_polygon.parquet      # CAL FIRE habitat polygons (raw)
├── scratch/
|   ├── ui_scratch.R.                # Exploratory ui changes
│   └── leaflet_scratch.R            # Exploratory data cleaning for map layer prep
└── shiny_dashboard/                 # The app lives here
    ├── global.R                     # Data loading, color palettes, choices_data
    ├── ui.R                         # All layout and UI elements
    ├── server.R                     # Reactive logic, map rendering, tree output
    ├── data/                        # Cleaned data read by global.R
    │   ├── leaflet_bird_points.parquet   # Survey points with species, GAP, habitat
    │   ├── species.parquet               # Species list for picker input
    │   ├── gap_clean.parquet             # GAP status polygons (cleaned)
    │   └── habitat_clean.parquet         # Habitat polygons (cleaned)
    ├── text/                        # Markdown content 
    └── www/                         # Static assets served by Shiny
```

------------------------------------------------------------------------

## The App — Three Tabs

### Story

A scroll-based narrative that walks through the project from motivation to findings. Sections cover:

-   The biodiversity crisis and California's 30x30 initiative
-   Why birds were used as a biodiversity proxy
-   Point Blue Conservation Science and the Avian Knowledge Network (AKN)
-   Project objectives, approach, and deliverables
-   California's habitat complexity and how we aggregated it
-   Survey methods (Point Count and Area Search)
-   Key findings: biodiversity patterns and focal species trends

**Tip:** Best experienced in full screen. Scroll slowly — background images are fixed for parallax effect.

------------------------------------------------------------------------

### Dashboard

An interactive map of AKN bird survey sites across California. Use the left panel to filter the data; the map updates when you click **Update Plot**.

| Filter | Description |
|----------------------------|--------------------------------------------|
| **Select Species** | Filter to sites where a species was recorded. Supports live search and Select All. |
| **Select Study Site** | Filter by named study area. Supports live search and Select All. |
| **Number of Observations** | Slider to filter sites by total observation count. |
| **Survey Method** | Checkbox to show only Point Count or Area Search sites. |
| **Habitat Types** | Filter by CAL FIRE habitat classification. |
| **GAP Status** | Filter by USGS GAP protection level (1–5). |

**Map layers** (toggled via the layer control, top right): - **Observations** — survey point markers; click any for species list, habitat, GAP status, and observation count - **GAP Status** — protection level polygons colored by GAP class - **Habitat Type** — CAL FIRE habitat polygons

Use **Reset Map** to clear all filters and restore the full dataset.

------------------------------------------------------------------------

### Choices

A collapsible tree documenting the analytical decisions made throughout the project. Use the **Filter by Phase** and **Filter by Category** dropdowns to narrow the view, then click any node to expand it.

Phases covered: **Data → Geospatial → Biodiversity → Focal Species → Statistical Models**

This section is intended for technical audiences and Point Blue scientists who want to understand or reproduce the workflow.

------------------------------------------------------------------------

## Data Sources

| Data Source | Type | Link | What to Download |
|------------------|------------------|------------------|------------------|
| USGS GAP Project | Protected areas polygons (GAP status) | [USGS GAP](https://www.sciencebase.gov/catalog/item/6759abcfd34edfeb8710a004) | `PADUS4_1_State_CA_GDB_KMZ` |
| CAL FIRE Vegetation by Wildlife Habitat Relationships 2022 | California vegetation habitat raster | [FVEG22](https://www.fire.ca.gov/what-we-do/fire-resource-assessment-program/gis-mapping-and-data-analytics) | `Vegetation by Wildlife Habitat Relationships 2022` |
| Avian Knowledge Network | Bird observation survey data (point count & area search) | [AKN](https://avianknowledge.net) | `area search` |
| Avian Knowledge Network | Bird observation survey data (point count & area search) | [AKN](https://avianknowledge.net) | `point count` |
| Partners in flight | Avian species of interest | [PIF](https://pif.birdconservancy.org/avian-conservation-assessment-database-scores/) | \`ACAD Regional your.date.xlsx (This is a gatcha as the date updates) |

All datasets are publicly available. AKN data were accessed through Point Blue Conservation Science's data platform.

------------------------------------------------------------------------

## Adding New Images

Place any image files in `shiny_dashboard/www/`. Reference them in `ui.R` by filename only (no path needed), e.g.:

``` r
style = "background-image: url('my_photo.jpg');"
tags$img(src = "my_photo.jpg")
```

------------------------------------------------------------------------

## Known Limitations

-   Survey points are spatially concentrated in **Northern California** — statewide inferences should be made cautiously
-   **GAP Status 1** lands are undersampled due to restricted access
-   Temporal sampling is uneven, with peaks around 1997 and 2005 from USGS data integration
