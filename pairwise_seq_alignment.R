library(Biostrings)
library (seqinr)
#FASTA file having many sequences is read
prok <- read.fasta("prok.fasta", seqtype="DNA")
# Subseting of sequences 1 and 2 from many sequences 
prok1 <-prok[1]
prok2 <- prok[2]
# Writing the subset sequences as individual fasta files. 
write.fasta(sequences = prok2, names = names(prok2), as.string=FALSE, file.out = "prok2.fasta")
write.fasta(sequences = prok1, names = names(prok1), as.string=FALSE, file.out = "prok1.fasta")
# reading fasta files from the directory 
read.fasta("prok1.fasta", seqtype = "DNA")
read.fasta("prok2.fasta", seqtype = "DNA")
# converting the Fasta files into String which can be aligned 
prok1 =paste(prok1, collapse = "")
prok2=paste(prok2, collapse = "")
# code for alignment
pairwiseAlignment(pattern = prok1, subject = prok2)
