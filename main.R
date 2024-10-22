
library(knitr)
library(yaml)

knitr::opts_chunk$set(background = NULL,
                      warning = TRUE,
                      prompt = TRUE,
                      comment = "#",
                      highlight = TRUE,
                      tidy = 'styler')

create_md <- function(dir_name = "", deleteAll = FALSE, index_premd = NULL,
                      main_list_name = "<b>Main List</b>", 
                      author_name = "<b>Author:</b> <span>Ramin Mojab</span>",
                      linksdir = "ltr"){
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
  else if (deleteAll)
    unlink(paste0(doc_dir, "/*"), recursive = TRUE)  
  
  all_titles <- sapply(rmd_files, function(f)extract_title(f))
  index_file_html <- paste0(dir_name, ".html")
  index_file_md <- paste0(doc_dir, "/", dir_name, ".md")
  get.ext.path <- function(ind, ext = "html", relative = ext == "html"){
    if (relative)
      paste0(dir_name, "_",tools::file_path_sans_ext(basename(rmd_files[[ind]])), ".", ext)
    else
      paste0(doc_dir, "/", dir_name, "_",tools::file_path_sans_ext(basename(rmd_files[[ind]])), ".", ext)
  }
  
  md_list <- list()
  for (i in seq_along(rmd_files)) { 
    
    file_md <- get.ext.path(i, "md")
    file_html <- get.ext.path(i, "html")
    prev_file_html <- if (i > 1) get.ext.path(i-1, "html") else NULL
    next_file_html <- if (i < length(rmd_files)) get.ext.path(i+1, "html") else NULL
    
    file_title <- all_titles[[i]]
    prev_file_title <- if (i > 1) all_titles[[i-1]] else NULL
    next_file_title <- if (i < length(rmd_files)) all_titles[[i+1]] else NULL
    
    text <- readLines(rmd_files[[i]])
    
    # Add title, author
    j <- which(text == "---")[[2]]
    
    text <- append(text, c(paste("# ", file_title),
                           paste0("<p style='font-size: 0.8em;'>", author_name,"</p>")), after = j)
    j <- j+2
      
    # Add links at the end
    text <- append(text, c("", "", "<hr/><div style='font-size: 0.8em; background-color: #f0f0f0; padding: 10px;'>"))
    text <- append(text, paste0("<ul dir='", linksdir  ,"'>"))
    if (!is.null(prev_file_html)) { 
      text <- append(text, paste0("<li><a href='", prev_file_html, "'>", prev_file_title, "</a></li>"))
    } 
    if (!is.null(next_file_html)) {
      text <- append(text, paste0("<li><a href='", next_file_html, "'>", next_file_title, "</a></li>"))
    } 
    text <- append(text, paste0("<li><a href='", index_file_html, "'>", main_list_name, "</a></li>"))
    text <- append(text, "</ul></div>")
    
    
    knit(text = text, output = file_md)
    md_list[[length(md_list)+1]] <- paste0("[",file_title,"](", file_html,")")
  }
  
  writeLines(paste(if (is.null(index_premd)) {""} else {index_premd},
                   paste0("- ", md_list)), con = index_file_md)
  list(md_list, index_file_md)
}

res <- create_md(dir_name = "matrix_book_fa", deleteAll = TRUE,
                 main_list_name = "<b>لیست مثال‌ها</b>", 
                 author_name = "<b>نویسنده:</b> <span>رامین مجاب</span>",
                 linksdir = "rtl")
res <- create_md(dir_name = "matrix_book")



