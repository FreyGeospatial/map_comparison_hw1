# load packages
library(raster)
library(rasterVis)

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
crosstab(bool_1971, bool_1985, long = T)
crosstab(bool_1985, bool_1999)

#return all unique value combinations of these two vectors
grid_ <- expand.grid(unique(bool_1971), unique(bool_1985))
# change column names of value combinations
names(grid_) <- c("from", "to")
# add ID column to grid_
grid_$code <- 1:nrow(grid_)
# add change column to grid
grid_$change <- grid_[,1] != grid_[,2]

change <- function(x){
  grid_[x[1] == grid_[,1] & x[2] == grid_[,2],'code']
}

# calculate values for a new raster object from another raster object using a formula
changeDet1 <- calc(stack(bool_1971,bool_1985), fun = change)

# dictionary
codes_ <- data.frame(ID = grid_$code,value = paste0('from ',grid_[,1],' to ',grid_[,2]))

# Create a Raster Attribute Table
rat[["Changes"]] <- codes_
levels(changeDet1) <- rat
# Plot
levelplot(changeDet1, par.settings=PuOrTheme(), xlab="", ylab="")


