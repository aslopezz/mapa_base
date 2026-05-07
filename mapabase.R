install.packages(c(
  "dplyr",
  "sf",
  "rnaturalearth",
  "ggplot2",
  "ggspatial"
))

library(dplyr)
library(sf)
library(rnaturalearth)
library(ggplot2)
library(ggspatial)

# Esto es extra
regiones <- ne_states(country = "Chile", returnclass = "sf")

# filtro para tener 1 region
region <- regiones %>%
  filter(grepl("BI", iso_3166_2), ignore.case = TRUE)

# mapa con el contorno de la región del biobio
mapa_region <- ggplot() +
  annotation_map_tile(type = "osm", zoomin = 0) +
  geom_sf(data = region, fill = NA, color = "red", size = 0.8) +
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "tl",
                         style = north_arrow_fancy_orienteering) +
  coord_sf(datum = st_crs(4326)) +
  labs(title = "Mapa Base",
       x = "Longitud", y = "Latitud") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

mapa_region

# Mapa Parque área bebedero
# area_parque <- st_read("parque-nonguen.shp")
bebederos <- st_read("bebederos-shp.shp")
area_bebederos <- st_read("area_parque_bebederos.shp")

mapa_parque <- ggplot() +
  annotation_map_tile(type = "osm", zoomin = 0) +
  geom_sf(data = area_bebederos, fill = NA, color = "transparent", size = 0) +
  geom_sf(data = bebederos, color = "orange", size = 2, alpha = 0.7) +
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "tl",
                         style = north_arrow_fancy_orienteering) +
  coord_sf(datum = st_crs(4326)) +
  labs(title = "Mapa Base Bebederos?",
       x = "Longitud", y = "Latitud") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

mapa_parque
