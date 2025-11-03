This repository archives codes that were used in the Nicotiana attenuata and Nicotiana obtusifolia genome assembly and gene annotation project.

Codes were used in the MOGON II cluster (Johannes Gutenberg University Mainz, Germany).

Explanation of Major Steps (in brief) for Nicotiana attenuata (NA):

1. BRAKER3: Predict genes using RNA-Seq reads and protein evidence.
2. Filtering: Remove short and TE-contaminated gene models.
3. BUSCO: Assess completeness of genome and gene models.
4. LTR Assembly Index (LAI): Assess genome assembly quality.

Explanation of Major Steps (in brief) for Nicotiana obtusifolia (NO):

1. BRAKER3 (two rounds): Predict genes using RNA-Seq reads and protein evidence. One round with only Iso-seq data (RNA-Seq) and one round with only Illumina data (RNA-Seq).
2. TSEBRA: Merge the results obtained from two separate BRAKER3 runs for a refined gene set.
3. Filtering: Remove short and TE-contaminated gene models.
4. BUSCO: Assess completeness of genome and gene models.
5. LTR Assembly Index (LAI): Assess genome assembly quality.
