#!/bin/bash
#generate population stats using vcflib popStats

#first need a sequential line of all vcf columns for number of samples to include in stats.
#for freebayes vcf files, use --GT flag
#need to be in conda environment where vcflib is installed, this is one of vcblib tools

#you should have already created a Genotyping environment, used here
module load anaconda2/4.4.0
source activate Genotyping

#change sequnence based on how many files you have, this is for 93 samples
sequence="$(seq -s ',' 0 93 )"
echo $sequence

popStats --type GT --target $sequence --file SNP_only_n7_SPECIES.vcf >SNP_only_n7_SPECIES_popstats.txt
