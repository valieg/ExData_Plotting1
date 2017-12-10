##
## This class is intended to take care for downloading and
## unpacking of the rough stuff(data files,...) for this
## project.
##
GetRoughData <- setRefClass("GetRoughData",
                       fields = list(fileUrl = "character",
                                     fileName = "character",
                                     filePath = "character",
                                     fileDoesExist = "logical")
                       ,
                       methods = list(
                           #'
                           #' Get the full file name from the rough file URL.
                           #'
                           #' @return
                           #'
                           roughFileName = function(){
                               fileName <<- basename(URLdecode(fileUrl))
                           },
                           #'
                           #' Get the full file name from the rough file URL.
                           #'
                           #' @param ... 
                           #'
                           #' @return
                           #'
                           roughFilePath = function(...){
                               filePath <<- file.path(..., fsep = .Platform$file.sep)
                           },
                           #'
                           #' Check if the 'fileName' does exist.
                           #'
                           #' @param fileName 
                           #'
                           #' @return
                           #'
                           roughFileDoesExist = function(fileName = fileName){
                               return(ifelse(TRUE == file.exists(file.path(filePath, fileName, fsep = .Platform$file.sep)),
                                             fileDoesExist <<- TRUE,
                                             fileDoesExist <<- FALSE))
                           },
                           #'
                           #' Download the rough stuff.
                           #'
                           #' @param fileUrl 
                           #'
                           #' @return
                           #'
                           roughFileDownload = function(fileUrl = fileUrl){
                               download.file(url = fileUrl,
                                             destfile = file.path(filePath, fileName, fsep = .Platform$file.sep),
                                             method = "curl")
                           },
                           #'
                           #' Unpack('unzip') the downloaded rough stuff.
                           #'
                           #' @param fileName 
                           #' @param packType 
                           #'
                           #' @return
                           #'
                           roughFileUnPack = function(fileName = fileName, packType = "zip"){
                               if("zip" == tolower(packType)){
                                   unzip(file.path(filePath, fileName, fsep = .Platform$file.sep),
                                         exdir = filePath)
                               }
                           }
                       )
)
