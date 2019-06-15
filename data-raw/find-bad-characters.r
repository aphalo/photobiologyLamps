output.file <- "./data-raw/NonASCII-test.txt"
file.remove(output.file)

dirs <- list.dirs("./data-raw")

for (d in dirs[-1]) {
  files <- list.files(d,
                      pattern = "*.dat$|*.data$|*.csv|*.CSV|*.txt|*.TXT|*.R$|*.r$", # *.xls|
                      full.names = TRUE)
  cat("****", files, sep = "\n", file = output.file, append = TRUE)
  for (f in files) {
    cat(f, sep = "\n", file = output.file, append = TRUE)
    NonASCII <- tools:::showNonASCIIfile(f)
    if (length(NonASCII))
      cat("-> ", NonASCII, sep = "\n", file = output.file, append = TRUE)
    else
      cat("OK", sep = "\n", file = output.file, append = TRUE)
  }
  
}
