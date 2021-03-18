Peter L. Morrell\
Falcon Heights, MN, USA\
09 March 2021

# Preparing files for VeP annotation
-   Jobs running on UMN MSI (ssh mesabi.msi.umn.edu)


```bash

srun -N 1 --ntasks-per-node=4  --mem-per-cpu=4gb -t 4:00:00 -p interactive --pty bash

module load htslib
module load bcftools/1.9
module load samtools/1.9

(grep ^"#" Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3; \
 grep -v ^"#" Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3 \
 | sort -k1,1 -k4,4n) | bgzip > Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz; \
 tabix -p gff Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz &

# bgzip and index genome
bgzip --threads 4 --index Vunguiculata_IT97K-499-35_v1.0.fa
# sort and index the vcf
bcftools sort FN27_de_novo_final_all.vcf.gz --output-type z --output-file FN27_de_novo_final_all_sort.vcf.gz &
```

-   Issues with the previous version of VeP, so I updated to the latest from GitHub and ran install
-   No exons in identified in the original GFF3. Using the GFF marked 'exon'
