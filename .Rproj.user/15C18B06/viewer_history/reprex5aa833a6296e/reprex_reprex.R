#' ---
#' output:
#'   md_document:
#'     pandoc_args: [
#'       '-f', 'markdown-implicit_figures',
#'       '-t', 'commonmark',
#'       --wrap=preserve
#'     ]
#' ---



#+ reprex-setup, include = FALSE
options(tidyverse.quiet = TRUE)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", error = TRUE)
knitr::opts_knit$set(upload.fun = knitr::imgur_upload)

#+ reprex-body
library(opendataes)
path_all_data_publishers <- function(path, param = NULL, ...) {
  opendataes:::make_url(paste0("catalog/dataset/publisher/", path), param = param, ...)
}

openes_data_publishers <- function (publisher) {
  stopifnot(length(publisher) == 1, is.character(publisher))

  lower_pub <- tolower(publisher)
  if (!(lower_pub %in% tolower(publishers_available$publisher_code))) stop("Publisher `", publisher, "` not available. Please check publishers_available to get the available ones.")
  path_dt_pub <- path_all_data_publishers(publisher)
  resp <- opendataes:::get_resp_paginated(path_dt_pub, num_pages = 1000)
  selected_dl <- resp$result$items
  data_explored <- lapply(selected_dl, function(x) {
    
      es_lang <- opendataes:::extract_language(x) == "es"
      if (any(es_lang)) {
          desc_datasets <- opendataes:::extract_description(x)[es_lang]
      }
      else {
          desc_datasets <- opendataes:::extract_description(x)[1]
      }
      
      id_datasets <- opendataes:::extract_endpath(x)
      url_datasets <- opendataes:::extract_url(x)
      formats_read <- opendataes:::determine_dataset_url(x)
      is_format_readable <- ifelse(length(formats_read) != 0, TRUE, FALSE)
      data_explored <- tibble::tibble(description = desc_datasets, 
                                      is_readable = is_format_readable,
                                      path_id = id_datasets, 
                                      url = url_datasets)
      data_explored
  })
  final_dt <- Reduce(rbind, data_explored)
  final_dt$publisher <- opendataes:::translate_publisher(code = toupper(publisher))
  final_dt <- final_dt[!duplicated(final_dt$description), ]
  final_dt[c("description", "publisher", "is_readable", "path_id", "url")]
}

openes_data_publishers("L01280796")



#' <sup>Created on `r Sys.Date()` by the [reprex package](https://reprex.tidyverse.org) (v`r utils::packageVersion("reprex")`)</sup>


