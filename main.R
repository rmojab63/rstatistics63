
library(knitr)
library(yaml)

create_md <- function(dir_name = ""){
  extract_title <- function(file) {
    lines <- readLines(file)
    yaml_lines <- lines[grep("^---$", lines)[1]:grep("^---$", lines)[2]]
    yaml_content <- yaml.load(paste(yaml_lines, collapse = "\n"))
    return(yaml_content$title)
  }
  
  rmd_files <- sort(list.files(path = file.path(getwd(), dir_name), 
                          pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE))
  doc_dir <- file.path(getwd(), "doc")
  if (!dir.exists(doc_dir))
    dir.create(doc_dir) 
  else
    unlink(paste0(doc_dir, "/*"), recursive = TRUE)  

  md_list <- list()
  for (file in rmd_files) {
    bname = tools::file_path_sans_ext(basename(file))
    o_file <- paste0(doc_dir, "/", dir_name, "_", bname, ".md")
    knit(input = file, output = o_file)
    md_list[[length(md_list)+1]] <- paste0("[",extract_title(o_file),"](",paste0(dir_name, "_", bname, ".html"),")")
  }
  index_file <- paste0(doc_dir, "/", dir_name, ".md")
  writeLines(paste0("- ", md_list), con = index_file)
  list(md_list, index_file)
}

res <- create_md(dir_name = "matrix_book")
 


