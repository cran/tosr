#' @name  tosR
#' @title tosR process
#' @description This function load de scopus and web of science files and generate
#'              the graph (relations betwen the cited references), the bibliometrix
#'              dataframe object, the tree of science for the subfields, the tree of
#'              science for all the cited references,
#' @param ... Names of scopus and web of science files
#' @author Sebastian Robledo
#' @return list with graph, data frame of citations, subfields and Tree of science
#
#' @export
#'
#' @examples
#' \dontrun{
#' my_tosr <- tosR("co-citation_209.txt",
#'                "co-citation_380.bib")
#' }
tosR <- function(...){

  info    <- tosr_load(...)
  g     <- info$graph
  nodes <- info$nodes
  biblio_wos_scopus   <- info$df

  message("Computing TOS SAP")
  ToS    <- tryCatch(tosSAP(g,biblio_wos_scopus,nodes),
                     error=function(cond) {
                       message('Error in Tos SAP')
                       return(NA)
                     },
                     warning=function(cond) {
                       message("Warning in TOS SAP")
                       # Choose a return value in case of warning
                       return(NULL)
                     })

  message("Computing TOS subfields")

  return(ToS)
}
