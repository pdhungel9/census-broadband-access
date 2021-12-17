# Census Data: Broadband Internet Access Discrepencies

This repository contains scripts used to analyze Census American Community Survey Data to identify internet broadband access deserts, and the demographics of those who lives there.

Written for Boston University Spark Project for class CS506
Ben Badnani, Esben Soevndahl Kok, Prathana Dhungel, Allison Nau

# Installing dependencies: 

Run 'pip install -r requirements.txt' to install all dependencies to run the ipynb files. 


## Viewing the Census Data Demographic Information Tables
 
Accessing the census data requires an API key which can be created [here](https://api.census.gov/data/key_signup.html). 
Save your API key in a file called "api.key".

Getting the zipcodes converted from each census tract requires an API key which can be created [here](https://www.huduser.gov/hudapi/public/register?comingfrom=1). Save your API key in a file called "hud_api.key".


## Streetmaps showing each block groups location and internet access


Zoomable, interactive html map with pop up icons for demographic, income, and zip code information of each block group:
Blue points represent areas with which less than 20% have broadband subscriptions. Red points represent areas with which more than 20% have no internet access. 
Purple points represent the intersections of those two groups. 
```
Interactive_map.html
```

Zoomable html map for the size of the total population:
```
total_popmap.html
```

Zoomable html map for proportion of the block group with no internet:
```
nointernet_map.html
```

Zoomable html map for proportion of the block group with a broadband subscription:
```
broadband_subscript_map.html
```

Zoomable html map for proportion of the block group with a broadband subscription for Cable, Fiber Optic, DSL, or similar:
```
broadband_CableFiberOpticDSL_map.html
```

## Scripts:

### Massachusetts and County Internet Access Heatmaps

To generate both the detailed zoomable html internet access heatmaps and the static heatmaps, run the following R markdown file (most easily done in Rstudio):
```
mapping_variables.Rmd
```

If you just want to see all the R code as well as the resulting figures, see:
```
mapping_variables.html
```

If the R packages are not already installed, run the install packages cell by setting "eval=TRUE".

R was used because it generated detailed maps using Census block group data. To generate the individual static maps (in addition to the html maps), switch "eval=FALSE" to "eval=TRUE" for each desired map. A Census API key must be generated and stored in the current working directory in "api.key". If running from within RStudio, you can either run all chunks within RStudio, or select "Knit to html" which will generate a report with all code and figures.

OpenStreetMap: https://www.openstreetmap.org/copyright 

