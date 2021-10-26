BSgenome <- readRDS("data/custom_BSgenome.rds")
in_gtf <- gzfile("data/Saccharomyces_cerevisiae.R64-1-1.51.gtf.gz", open = "rt")

chrom_len <- seqlengths(BSgenome)
is_circular <- names(chrom_len) %in% c("chrM", "chrMT", "MT",
                                           "chrPltd", "Pltd")

# Below works fine:
chrominfo <- data.frame(chrom = gsub('^chr','',names(chrom_len)),
                            length = unname(chrom_len),
                            is_circular = is_circular)

# Below won't work:
# chrominfo <- data.frame(chrom = names(chrom_len),
                            length = unname(chrom_len),
                            is_circular = is_circular)

genome_metadata <- metadata(BSgenome)

TxDb <- makeTxDbFromGFF(file = in_gtf,
                            format = "gtf",
                            dataSource = NA,
                            organism = NA, # if genome_metadata$genome, unknown organism error
                            taxonomyId = NA,
                            chrominfo = chrominfo,
                            miRBaseBuild = NA)
