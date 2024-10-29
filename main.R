
library(knitr)
library(yaml)
library(RefManageR)

knitr::opts_chunk$set(background = NULL,
                      warning = TRUE,
                      prompt = TRUE,
                      comment = "#",
                      highlight = TRUE,
                      tidy = 'styler')
knitr::opts_chunk$set(
  fig.show='hold',  
  dev = "svglite",
  fig.align='center', 
  dev.args = list(scaling = 0.9, bg = "transparent")
)

create_md <- function(dir_name = "", deleteAll = FALSE, index_premd = NULL,
                      main_list_name = "<b>Main List</b>", 
                      author_name = "<b>Author:</b> <span>Ramin Mojab</span>"){
  fig.path <- paste0("assets/", "images/", dir_name, "/")
  knitr::opts_chunk$set(fig.path = fig.path)
  
  extract_title <- function(file) {
    print(paste0("   extracting title: ", file))
    lines <- readLines(file)
    yaml_lines <- lines[grep("^---$", lines)[1]:grep("^---$", lines)[2]]
    yaml_content <- yaml.load(paste(yaml_lines, collapse = "\n"))
    return(yaml_content$title)
  }
  order2 <- function(filenames, splitchar= ".") {
    section_numbers <- sapply(filenames, function(s)sub(".*?(\\d+\\.\\d+).*", "\\1", s)) 
    split_chars <-  strsplit(section_numbers, splitchar, fixed = TRUE) 
    numeric_matrix <- do.call(rbind, lapply(split_chars, as.numeric)) 
    order(numeric_matrix[, 1], numeric_matrix[, 2])
  }
  
  
  rmd_files <- sort(list.files(path = file.path(getwd(), dir_name), 
                               pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE))
  doc_dir <- file.path(getwd(), "doc")
  if (!dir.exists(doc_dir))
    dir.create(doc_dir) 
  else if (deleteAll)
    unlink(paste0(doc_dir, "/*"), recursive = TRUE)
  unlink(paste0(getwd(), "/", fig.path, "*"), recursive = TRUE) # delete images

  
  all_titles <- sapply(rmd_files, function(f)extract_title(f))
  index_file_html <- paste0(dir_name, ".html")
  index_file_md <- paste0(doc_dir, "/", dir_name, ".md")
  get.ext.path <- function(ind, ext = "html", relative = ext == "html"){
    if (relative)
      paste0(dir_name, "_",tools::file_path_sans_ext(basename(rmd_files[[ind]])), ".", ext)
    else
      paste0(doc_dir, "/", dir_name, "_",tools::file_path_sans_ext(basename(rmd_files[[ind]])), ".", ext)
  }
  bibs <- RefManageR::ReadBib("references.bib")
  
  md_list <- list()
  file_names <- list() # this determines the sorting
  for (i in seq_along(rmd_files)) { 
    
    file_md <- get.ext.path(i, "md")
    file_html <- get.ext.path(i, "html")
    prev_file_html <- if (i > 1) get.ext.path(i-1, "html") else NULL
    next_file_html <- if (i < length(rmd_files)) get.ext.path(i+1, "html") else NULL
    
    file_title <- all_titles[[i]]
    prev_file_title <- if (i > 1) all_titles[[i-1]] else NULL
    next_file_title <- if (i < length(rmd_files)) all_titles[[i+1]] else NULL
    
    text <- readLines(rmd_files[[i]])
    
    # Handle bibliography (format: @key or [@key]) 
    usedbibs <- c()
    for (t in seq_along(text)){
      # first search for [@key]
      keys_text <- stringr::str_extract_all(text[[t]], "(?<=\\[@)[^\\]]+(?=\\])")[[1]]
      for (k in keys_text){
        if (k %in% names(bibs)){
          text[[t]] <- gsub(paste0("\\[@", k, "\\]"), Citep(bibs, k), text[[t]])
          usedbibs <- append(usedbibs, k)
        }
      }
      # search for @key
      keys_text <- stringr::str_extract_all(text[[t]], "(?<=@)\\S+")[[1]]
      for (k in keys_text){
        if (k %in% names(bibs)){
          text[[t]] <- gsub(paste0("@", k), Citet(bibs, k), text[[t]])
          usedbibs <- append(usedbibs, k)
        }
      }
    }
    if (length(usedbibs) > 0){
      text <- append(text, paste(c("","### References", format(bibs[usedbibs], 
                                                         style = "text", .sort = TRUE)),
                                 collapse = "\n\n")) #TODO: check 'style = "text"'
    }
     
    # Add title, author (TODO: move these to layout and use liquid)
    j <- which(text == "---")[[2]]
    
    text <- append(text, c(paste("## ", file_title),
                           paste0("<p style='font-size: 0.8em;'>", author_name,"</p>")), after = j)
    j <- j+2
       
    # Add links at the end
    lst <- c("","","<p style='margin-bottom:3cm;'></p><hr/>", "")
    if (!is.null(prev_file_html))
      lst <- append(lst, paste0("- [",prev_file_title, "](", prev_file_html, ")"))
    if (!is.null(next_file_html))
      lst <- append(lst, paste0("- [",next_file_title, "](", next_file_html, ")"))
    lst <- append(lst, paste0("- [",main_list_name, "](", index_file_html, ")"))
             
    text <- append(text, paste0(lst, collapse = "\n"))

    knit(text = text, output = file_md)

    
    # fix the image paths (TODO: is there better way?):
    writeLines(gsub("assets/images/", "/rstatistics63/assets/images/", 
                    readLines(file_md)), file_md)
     
    md_list[[length(md_list)+1]] <- paste0("[",file_title,"](", file_html,")")
    file_names[[length(file_names)+1]] <- file_html
  }
  
  md_list <- md_list[order2(unlist(file_names), ".")]
  writeLines(c(if (is.null(index_premd)) {""} else {index_premd},
               paste0("- ", md_list)), con = index_file_md)
  list(md_list = md_list, index_file_md = index_file_md)
  
  #TODO: compress svg files (see https://github.com/scour-project/scour)
  #svg_files <- list.files(paste0(getwd(), "/", fig.path), pattern = "\\.svg$", full.names = TRUE)  
  #for (f in svg_files) {
  #  command <- paste0("inkscape ", f, " --export-plain-svg", " --export-filename=", f)
  #  system(command)
  #}
  
}

res <- create_md(dir_name = "matrix_book_fa", deleteAll = TRUE,
                 index_premd = paste0(c("---", "forcedir: rtl", "---"), collapse = "\n"),
                 main_list_name = "<b>لیست مثال‌ها</b>", 
                 author_name = "<b>نویسنده:</b> <span>رامین مجاب</span>")
res <- create_md(dir_name = "matrix_book")



