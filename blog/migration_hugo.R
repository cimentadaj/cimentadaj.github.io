dir_rmds <- "/Users/cimentadaj/Downloads/gitrepo/cimentadaj.github.io/_source"

folders <-
  list.files(
    dir_rmds,
    pattern = "(*.).Rmd$",
    recursive = TRUE,
    full.names = TRUE
  )

new_tags <-
  list(
    c("R"),
    c("R", "packages"),
    c("EDA", "education", "inequality"),
    c("R", "simulation", "gelman"),
    c("R"),
    c("education", "inequality"),
    c("R", "multilevel", "gelman"),
    c("R", "multilevel", "gelman"),
    c("R", "gelman"),
    c("PISA","shiny", "R", "projects"),
    c("PISA", "R", "projects"),
    c("inequality", "education"),
    c("packages", "R", "projects"),
    c("simulation", "R", "machine-learning"),
    c("simulation", "R", "machine-learning"),
    c("scraping", "R", "EDA", "projects"),
    c("latex", "knitr", "R")
  )

yaml_list <- rep(list(character()), length(folders))

for (each in 17) {
  
  # read lines
  rmd <- readLines(folders[each])
  
  # identify yaml
  end_yaml_header <- which(grepl("---", rmd))[2]
  yaml_header <- rmd[seq_len(end_yaml_header)]
  
  # extract title and date
  title <- yaml_header[grepl("^title\\:", yaml_header)]
  yaml_date <- stringr::str_extract(folders[each], "\\d{4}-\\d{2}-\\d{2}")
  
  # extract slug
  title_change <- trimws(gsub("[[:punct:]]|title", "", title))
  slug <- stringr::str_to_lower(gsub("\\s","-", title_change))
  
  # tags
  tags <- paste0("[", paste0(paste0("'", new_tags[[each]], "'"), collapse = ", "), "]")
  
  
  # create new yaml
  new_yaml <-
    c("---",
    title,
    "author: Jorge Cimentada",
    paste0("date: '", yaml_date, "'"),
    paste0("slug: ", slug),
    paste0("tags: ", tags),
    "---"
  )
  
  # remove previous yaml
  rmd <- rmd[-seq_len(end_yaml_header)]
  # add new yaml
  rmd <- c(new_yaml, rmd)
  
  folder_name <- paste0(yaml_date, "-", slug)
  full_dir <- file.path("./content/blog", folder_name)
  file_name <- file.path(full_dir, paste0(folder_name, ".Rmd"))
  
  dir.create(full_dir, recursive = TRUE)
  
  writeLines(rmd, con = file_name)

}
