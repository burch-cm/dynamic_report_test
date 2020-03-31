library(rmarkdown)
library(prettydoc)
library(fs)

fn_names <- stringr::str_remove(list.files("./raw_data", 
                                           full.names = FALSE), 
                                ".xlsx")

files <- fs::path_abs(list.files("./raw_data/", full.names = TRUE))

make_report <- function(filename, template = "./src/test1.Rmd") {
    
    output_fn <- paste0("report_", 
                        stringr::str_remove(fs::path_file(filename),
                                            "\\..*$"),
                        ".html")
    
    rmarkdown::render(
        input = template,
        output_format = html_pretty(theme = "architect",
                                    highlight = "github"),
        output_file = output_fn,
        params = list(data = filename),
        clean = TRUE,
        quiet = TRUE
    )
    
    fs::file_move(paste0("./src/", output_fn),
                  paste0("./reports/",
                         output_fn))
    
}

purrr::walk(files, make_report)