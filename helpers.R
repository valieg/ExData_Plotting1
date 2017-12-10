##
## A bunch of handy functions.
##
#' Load a list of libraries, checking if the attachment to the calling script
#' is successful.
#'
#' @param librariesList
#'
#' @return
#'
loadLibraries <- function(librariesList){
    
    result <- TRUE
    
    for (lib in librariesList) {
        if(FALSE == library(lib, character.only = TRUE, logical.return = TRUE)){
            result <- lib
            break()
        }
    }
    
    return(result)
}
