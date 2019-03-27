# Code for DotPlot 
# Created at 27th March 2019
# Wroking at home :) 
# seqinr library is needed for this dotplot 
# Code can also be used for DNA sequences 
library(seqinr)
# Protein fasta file is read, having many sequences in it.
protein <- read.fasta("cox1multi.fasta", seqtype =  "AA")
# The dotplot is two dimensional therefore two sequences are fetched out
protein1 <- protein[1]
protein2 <-protein[2]
# Two above sequences are written in fasta format
write.fasta(sequences = protein1, names = names(protein1), as.string = FALSE, file.out = "protein1.fasta")
write.fasta(sequences = protein2, names = names(protein2), as.string = FALSE, file.out = "protein2.fasta")
# Both sequences are read 
pro1 <- read.fasta("protein1.fasta", seqtype = "AA")
pro2 <-read.fasta ("protein2.fasta", seqtype = "AA")
# Converted into strings 
pro1 <- paste(pro1, collapse = "")
pro2 <- paste(pro2, collapse = "")

# Converted into vector
pro1 <- s2c(pro1)
pro2 <- s2c(pro2)
# DotPlot construction, wsize = window size, nmatch = number of amino acids/nucleotide matching. 
# nmatch should not excceds to wsize number.
dotPlot(pro1, pro2, wsize = 100, wstep = 100, nmatch = 100, main = "Human vs Mouse Cox1 Dotplot\nwsize = 3, wstep = 3, nmatch = 3")

