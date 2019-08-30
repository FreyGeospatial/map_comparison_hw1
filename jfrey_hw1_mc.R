# load packages
library(raster)

# load data
lc_1971 <- raster("Landcover01/1971Landcover01.rst")
lc_1985 <- raster("Landcover01/1985Landcover01.rst")
lc_1999 <- raster("Landcover01/1999Landcover01.rst")

# reclassification matrix: from, to, becomes. 2 becomes non-barren
barren <- c(2, 3, 1)
non_barren <- rbind(c(1, 2, 2), c(3, 5, 2))
my_reclass <- rbind(barren, non_barren)

boolean <- reclassify(lc_1971, rcl = my_reclass)
plot(boolean)
legend("topright", legend = c("Built", "Barren", "Forest", "Water"), fill = c("red", "yellow", "green", "blue"))
