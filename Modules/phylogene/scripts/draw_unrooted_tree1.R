library(getopt)

h <- function(x) {
    cat("Usage: Rscript --vanilla draw_unrooted_tree.R -i Newick_file_name [-o Prefix_of_output_files (output)] [-h]\n\n")
    quit(save="no", status=x)
}

opt <- getopt(matrix(c(
    'help',   'h', 0, "logical",
    'prefix', 'o', 1, "character",
    'newick', 'i', 1, "character"
), ncol=4, byrow=TRUE));

if (! is.null(opt$help)) { h(0) }

file.prefix <- ifelse(is.null(opt$prefix), "output", opt$prefix)

if (! is.null(opt$newick)) {
    newick.file <- opt$newick
    if (! file.exists(newick.file)) { cat(sprintf("Newick file (%s) was not found!\n", newick.file)); h(1) }
} else {
    h(1)
}

library(ape)

image_file.name <- paste(file.prefix, ".ml.pdf", sep = "")

tree.newick <- read.tree(newick.file)
pdf(image_file.name, width = 10, height = 10)
plot(tree.newick, "unrooted", edge.width=2, cex=1)
dev.off()
