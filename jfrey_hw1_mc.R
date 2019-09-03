# load packages
library(raster)

# load data
lc_1971 <- raster("Landcover01/1971Landcover01.rst")
lc_1985 <- raster("Landcover01/1985Landcover01.rst")
lc_1999 <- raster("Landcover01/1999Landcover01.rst")

# look at data
plot(lc_1971)
legend("topright", legend = c("Built", "Barren", "Forest", "Water"), fill = c("red", "yellow", "green", "blue"))

# reclassification matrix: from, to, becomes. 2 becomes non-barren
barren <- c(2L, 1L)
non_barren <- rbind(c(1L, 2L), c(3L, 2L), c(4L, 2L))
my_reclass <- rbind(barren, non_barren)
rownames(my_reclass) <- NULL

bool_1971 <- reclassify(lc_1971, rcl = my_reclass)
plot(bool_1971, main = "Barren and Non-Barren Land Cover: 1971")

bool_1985 <- reclassify(lc_1985, rcl = my_reclass)
plot(bool_1985, main = "Barren and Non-Barren Land Cover: 1985")

bool_1999 <- reclassify(lc_1999, rcl = my_reclass)
plot(bool_1999, main = "Barren and Non-Barren Land Cover: 1999")

# cross tabulation
crosstab(bool_1971, bool_1985)
crosstab(bool_1985, bool_1999)

plot(lc_1999, reclassify(lc_1999, rcl = my_reclass))
