
#!/bin/bash
#BSUB -q short
#BSUB -W 4:00
#BSUB -n 4
#BSUB -R rusage[mem=4000]
#BSUB -R "span[hosts=1]"
#BSUB -e depth.err
#BSUB -oo depth.log




#generate a region list for freebayes from one Bam file breaking apart by depth into 10000 regions

module load samtools/1.9
samtools depth  YOUR_BAM_FILE_sortfltr.bam| coverage_to_regions.py PATH/TO/REFERENCE/genomic.fna.fai 10000 >targets.bed
