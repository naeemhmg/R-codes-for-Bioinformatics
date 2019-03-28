# Dated 28th March, 2019
# The first version of code for Mutliple Sequences alignment. 
# This is simple code for MSA and later on we will improve it with reference to color coding
# The default matrix is used for alignment but it can be specified.
# More refined version of the code will be published next week
library(seqinr)
library(Biostrings)
library(msa)
# The following code is used to read the sequences from the fasta file
# this code can also be used in the pairwise alignment to avoid the paste function
protein_seq <- readAAStringSet("cox.fasta")
# Code to align the sequenes presnet in the fasta file.
multi_seq <- msa(protein_seq)
multi_seq
# The code is used to show the complete alignment 
print(multi_seq, show="complete") 
# Conversion of alignment to string to write it 
multi_seq <- as(multi_seq,"AAStringSet")
# Writing of strings to output file. 
writeXStringSet(multi_seq, file= "Multi_alignment.fasta")

