#!/bin/bash
#BSUB -q short
#BSUB -W 4:00

module load anaconda2/4.4.0
source activate Genotyping

vcffilter -f "QUAL > 20" all_SPECIES_n7.vcf  | vcfallelicprimitives >SNP_only_n7_SPECIES.vcf
