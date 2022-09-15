#' normvar: variable normalization
#'
#' @param x numeric
#'
#' @return double
#' @export normvar
#'
#' @examples 'void for now'

normvar <- function(x) {

  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

}
