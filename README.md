This repository archives codes that were used in the Nicotiana attenuata and Nicotiana obtusifolia genome assembly and genome annotation project.

Codes were used in the MOGON II cluster (Johannes Gutenberg University Mainz, Germany).

Explanation of Major Steps (in brief) for Nicotiana attenuata:

1. Repeat-masking of the genome assembly.
2. BRAKER3: Predict genes using RNA-Seq reads and protein evidence.
3. Filtering: Remove short and TE-contaminated gene models.
4. BUSCO: Assess completeness of genome and gene models.
5. LTR Assembly Index (LAI): Assess genome assembly quality.

Explanation of Major Steps (in brief) for Nicotiana obtusifolia:

1. Repeat-masking of the genome assembly.
2. BRAKER3 (two rounds): Predict genes using RNA-Seq reads and protein evidence. One round with only Iso-seq data (RNA-Seq) and one round with only Illumina data (RNA-Seq).
3. TSEBRA: Merge the results obtained from two separate BRAKER3 runs for a refined gene set.
4. Filtering: Remove short and TE-contaminated gene models.
5. BUSCO: Assess completeness of genome and gene models.
6. LTR Assembly Index (LAI): Assess genome assembly quality.
