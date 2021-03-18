#!/bin/bash -l
#SBATCH --time=8:00:00
#SBATCH --ntasks=8
#SBATCH --mem=10g
#SBATCH --tmp=10g
#SBATCH --mail-type=ALL  
#SBATCH --mail-user=pmorrell@umn.edu 

# This script runs Variant effect Predictor (VeP) on a set of variants
# It requires a VCF, GFF, and fasta file as input

module load htslib/1.9
module load perl/modules.centos7.5.26.1

#    Variant sets should be either 'all', deletions', 'insertions', 'snps', 'common', or 'rare'
VARIANT_SET=all

cd /panfs/roc/groups/9/morrellp/pmorrell/Workshop/Cowpea/analysis/VeP

/home/morrellp/shared/Software/ensembl-vep-release-97.3/vep \
    -i /panfs/roc/groups/9/morrellp/pmorrell/Workshop/Cowpea/Vunguiculata_540_v1.2_allfiltered_sort.vcf.gz \
    --gff /panfs/roc/groups/9/morrellp/pmorrell/Workshop/Cowpea/Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz \
    --fasta /panfs/roc/groups/9/morrellp/pmorrell/Workshop/Cowpea/Vunguiculata_IT97K-499-35_v1.0.fa.gz \
    --species vigna_unguiculata \
    --total_length \
    --check_svs \
    --verbose \
    --format vcf \
    --force \
    --warning_file Cowpea_vep_err_${VARIANT_SET}.txt \
    -o Cowpea_${VARIANT_SET}.txt
