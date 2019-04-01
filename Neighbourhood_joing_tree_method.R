# Code for Neighbourhood Joining Method
# Following Libraries are needed
library(seqinr)
library(msa)
library (Biostrings)
library (ape)

# Reading of Fasta file from the home directory 
seq_file <- readDNAStringSet("prok.fasta")
# Making the Multiple Sequence Alignment because it is needed
ms_align <- msa(seq_file)
# Converting the MSA into seqinr alignment 
ms_align2 <- msaConvert(ms_align, type = "seqinr::alignment")
# creating distance matrix of sequences on which the phylogenetic tree will be constructed 
distance_matrix <- dist.alignment(ms_align2)
distance_matrix
# Conversion of distance matrix into phylogenetic tree
phylogenetic_tree <- nj(distance_matrix)
# Ploting of Phylogenetic tree
plot(phylogenetic_tree)
