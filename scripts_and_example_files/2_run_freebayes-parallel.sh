#!/bin/bash

#use freebayes to generate a vcf file with all samples in a dataset

#BSUB -q long
#BSUB -W 6:00
#BSUB -n 60
#BSUB -R rusage[mem=1048]
#BSUB -R "span[hosts=1]"
#BSUB -e freebayes.err
#BSUB -oo freebayes.log


module load freebayes/1.3.1
module load picard/2.22.2
module load samtools/1.9

source /share/pkg/condas/2018-05-11/bin/activate && conda activate freebayes_1.3.1
#first add readgroup ids to bam files in case they aren't there already with picard- if unsure, just do this step
#run this script from within the directory containing your sorted, filtered bam files

reference=/path/to/reference/genome.fna

for file in *sortfltr.bam
do
date
echo $file
sample=$(basename $file _sortfltr.bam )
#echo $sample
java -jar /share/pkg/picard/2.17.8/picard.jar AddOrReplaceReadGroups  I= $file O= "$sample"_RG_sortfltr.bam RGID= $sample RGLB= $sample RGPL=illumina RGPU=unit1 RGSM= $sample
done

#index new bam files
for file in *_RG_sortfltr.bam
do
samtools index $file
done


#make new bam file list
ls *_RG_sortfltr.bam > bamlist.txt

#make sure your targets.bed file is in the directory you
freebayes-parallel ./targets.bed 60 -f $reference -L ./bamlist.txt --use-best-n-alleles 7 >all_SPECIES_n7.vcf

conda deactivate && conda deactivate
