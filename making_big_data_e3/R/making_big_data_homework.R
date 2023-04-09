#' making_big_data_e3
#'
#' A package for downloading a data asset, adding noise to numeric arrays, and accessing the data asset.
#' 
#' @docType package
#' @name making_big_data_e3
#' @keywords package
#' @import utils
#' 
#' @export
GetDataAsset <- function(url,
                         target_extension = ".csv"){
  # # Download and unzip the data asset
  # url <- "https://www.dropbox.com/s/5mzc60tbh09ew49/lalonde%20nsw.csv.zip?dl=1"
  # temp <- tempfile(fileext = ".zip")
  # download.file(url, temp)
  # data <- unzip(temp)
  # unlink(temp)
  # # Load the data into the R session
  # data <- read.csv(data)
  # return(data)
  
  # clean URL if from dropbox
  url <- gsub(url, pattern="https://www.dropbox.com",
              replace="https://dl.dropboxusercontent.com")
  url <- gsub(url, pattern="www.dropbox.com", replace="dl.dropboxusercontent.com")
  url <- gsub(url, pattern="dropbox.com", replace="dl.dropboxusercontent.com")
  
  # setup temporary folder, download .zip into it, unzip
  temp_folder_name_zip <- "tmp1432351232142323196039z"
  temp_folder_zip <- tempfile(pattern = temp_folder_name_zip)
  
  temp_folder_name_unzip <- "tmp1432351232142323196039u"
  temp_folder_unzip <- tempfile(pattern = temp_folder_name_unzip)
  
  # download
  download.file( url, destfile =  temp_folder_zip)
  
  # unzip into folder
  unzip(temp_folder_zip,
        junkpaths = T,
        exdir = temp_folder_unzip)
  
  # load unzipped file into memory as a data.table
  file_in_zip <- list.files( temp_folder_unzip )
  file_in_zip <- grep(file_in_zip,pattern="\\.csv",value = T)
  returned_dt <- data.table::fread(
    sprintf("%s/%s", temp_folder_unzip, file_in_zip) )
  
  # cleanup
  file.remove( temp_folder_zip )
  file.remove( temp_folder_unzip )
  
  # return
  return( returned_dt )
}


#' @export
AnalysisFunction <- function(x, training) {
  if (training) {
    # Add white noise to the input array
    noise <- runif(length(x), -1, 1)
    x <- x + noise
  }
  return(x)
}

#' @docType data
#' @name PackageDataAsset
#' @keywords datasets
#' @format A data frame with 445 rows and 11 columns.
#' @source https://www.dropbox.com/s/5mzc60tbh09ew49/lalonde%20nsw.csv.zip?dl=0
#' 
#' @export
PackageDataAsset <- GetDataAsset()
