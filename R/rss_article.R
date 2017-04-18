#' Royal Statistical Society Journal Format
#'
#' Format for creating articles for Royal Statistical Society
#' Adapted from \url{http://www.rss.org.uk/RSS/Publications/Journals/Journals_get_involved/RSS/Publications/Journals_sub/Get_Involved.aspx}
#' @inheritParams rmarkdown::pdf_document
#' @param ... Arguments to \code{rmarkdown::pdf_document}
#'
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#' @export
#'

rss_article <- function(...,
                        keep_tex = TRUE) {
  fmt <- rmarkdown::pdf_document(
    ...,
    highlight = NULL,
    citation_package = "natbib",
    template =
      system.file("rmarkdown",
                  "templates",
                  "rss_article",
                  "resources",
                  "template.tex",
                  package = "rticles"),
    keep_tex = keep_tex
  )

  fmt$inherits <- "pdf_document"
  fmt$knitr$knit_hooks$source <- function(x, options) {
    if (options$prompt && length(x)) {
      x <- gsub("\\n", paste0("\n", getOption("continue")), x)
      x <- paste0(getOption("prompt"), x)
    }
    paste0(
      c(
        '\n\\begin{lstlisting}[language=',
        options$engine,
        "]",
        x,
        '\\end{lstlisting}',
        ''
      ),
      collapse = '\n'
    )
  }
  fmt
}