file_list <- list.files(path = "./lead_sheets", pattern = '\\.Rmd')
check_special_chars = function(filename) {
  reg = getFromNamespace('.shell_chars_regex', 'rmarkdown')
  for (i in grep(reg, filename)) warning(
    'The filename "', filename[i], '" contains special characters. ',
    'You may rename it to, e.g., "', gsub(reg, '-', filename[i]), '".'
  )
  if (!is.null(i)) stop('Filenames must not contain special characters')
  filename
}
check_special_chars(file_list)
