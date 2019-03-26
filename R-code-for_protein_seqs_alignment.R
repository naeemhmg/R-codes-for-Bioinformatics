# This code is used for alignment of protein sequences in R. Two libraries are needed 
library(seqinr)
library(Biostrings)
#Reading the main fasta file containing all sequences downloaded from NCBI
prot_main <- read.fasta(file="CystSeq.fasta", seqtype = "AA")
# Subseting first two sequences from the main file.
first_seq <- prot_main[1]
second_seq <- prot_main[2]
#Writing two sequences as fasta format seperatly in working directory 
write.fasta(sequences = first_seq, names=names(first_seq), as.string = FALSE, file.out = "first_seq.fasta")
write.fasta(sequences = second_seq, names=names(second_seq), as.string=FALSE, file.out="second_seq.fasta")
#Reading of proteins sequences files from working directory 
first_seq <-read.fasta("first_seq.fasta", seqtype = "AA")
second_seq <- read.fasta("second_seq.fasta", seqtype = "AA")
# Converting sequences as string 
first_seq <- paste(first_seq, collapse = "")
second_seq <- paste(second_seq, collapse = "")
# Alignment of two sequences using Subject and Pattern function
align_protein <- pairwiseAlignment(pattern = first_seq, subject= second_seq)
# Getting summary of alignment 
summary(align_protein)
# Converting alignment into String 
align_protein_string <- BStringSet(c(toString(pattern(align_protein)), toString(subject(align_protein))))
# Wirting alignment in text format.
writeXStringSet(align_protein_string, "protein_alignment.txt", format ="FASTA")
