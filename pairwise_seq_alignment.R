# The following code is used for DNA Sequences only. 
library(Biostrings)
library (seqinr)
#FASTA file having many sequences is read. The name of fasta file is "seq"
seq <- read.fasta("seq.fasta", seqtype="DNA")
# Subseting of sequences 1 and 2 from many sequences 
seq1 <-seq[1]
seq2 <- seq[2]
# Writing the subset sequences as individual fasta files. 
write.fasta(sequences = seq1, names = names(seq1), as.string=FALSE, file.out = "seq1.fasta")
write.fasta(sequences = seq2, names = names(seq2), as.string=FALSE, file.out = "seq2.fasta")
# reading fasta files from the directory 
read.fasta("seq1.fasta", seqtype = "DNA")
read.fasta("seq2.fasta", seqtype = "DNA")
# converting the Fasta files into String which can be aligned 
seq1 =paste(seq1, collapse = "")
seq2=paste(seq2, collapse = "")
# code for alignment
pairalign <- pairwiseAlignment(pattern = seq1, subject= seq2)
#Overall Summary of the alignment, letting us know about number of mismatches and their positions. 
summary(pairalign)
# there may be need to store the alignment for later use in this case, we need to write it down
# but before writing the alignment down in local directory, we need to convert the alignment into 
# string by using a "BstringSet" function of Biostrings library. 
align_string = BStringSet(c(toString(pattern(pairalign)), toString(subject(pairalign))))
#to write the alignment "WriteXStringSet" function will be used
writeXStringSet(align_string, "pair_wise_alignment.txt", format="FASTA")
