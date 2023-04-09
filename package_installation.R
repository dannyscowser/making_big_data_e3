########################################################
#### DOCUMENTATION GENERATION + INSTALL INSTRUCTIONS ###
########################################################

# Specify package name
package_name <- "making_big_data_e3"

# Generate documentation
{
  setwd(sprintf("~/Documents/%s-software",package_name))
  devtools::document(sprintf("./%s",package_name))
  try(file.remove(sprintf("./%s.pdf",package_name)),T)
  system(sprintf("R CMD Rd2pdf %s",package_name))
}

# Instructions for package installation + use
{
  # Download package via github
  devtools::install_github("dannyc/making_big_data_e3/making_big_data_e3")

  # See package documentation for help
  # ?LinkOrgs::FastFuzzyMatch
  # ?LinkOrgs::AssessMatchPerformance
  # ?LinkOrgs::LinkOrgs

  # Load package
  library(making_big_data_e3)

  # Create synthetic data to try everything out
  x_orgnames <- c("apple","oracle","enron inc.","mcdonalds corporation")
  y_orgnames <- c("apple corp","oracle inc","enron","mcdonalds co")
  x <- data.frame("orgnames_x"=x_orgnames)
  y <- data.frame("orgnames_y"=y_orgnames)

  # Perform a simple merge with package
  linkedOrgs <- LinkOrgs(x = x,
                         y = y,
                         by.x = "orgnames_x",
                         by.y = "orgnames_y",
                         algorithm = "bipartite", openBrowser= F)

  # Print results
  print( linkedOrgs )
}
