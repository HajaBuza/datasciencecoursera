# function merge all files from directory 
mergefile <- function() {
     directory <- c(".", "./test", "./test/Inertial Signals", "./train", "./train/Inertial Signals")
     if (!identical(directory, list.dirs())) {
          return("You change name or choose invalid direcotry!")
     }
     filepaths <- Sys.glob('./*.txt')
     filepathtest <- Sys.glob('./test/Inertial Signals/*.txt')
     #filepathstrain <-  Sys.glob(('./train/Inertial Signals/*.txt'))
}