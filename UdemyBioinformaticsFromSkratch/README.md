### Learn Bulk RNA-Seq Data Analysis Notes

- Sanger Sequencing
  - One gene at a time
- Next Generation Sequencing
  - millions of fragments at once
  - FastQ files that need processing
- FASTQ File -> SAM/BAM Files -> Feature Count Matrix
  - Quality Check
  - Alignment
  - Extraction of counts
- FASTQ
  - Header
  - Sequence
  - plus sign (+)
  - Quality Score
    - ! - 0
    - alphabets (A-I) - Highest Scores
- SAM/BAM
- Reads
  - Each sequence fragment is a read
 

## Linux in WSL 

#### Instalation of tools
- sudo apt update
- sudo apt upgrade
- Install:
  - Fastqc
  - hisat2
  - subread
  - samtools

#### First Analysis
- cd /mnt
- cd change to correct folder
- fastqc test_udemy.fastq
![Untitled](https://github.com/Shayne-Falco/BioinformaticsSkills/assets/96263317/8c797a54-3c67-4f2b-a2de-21cdfcea2861)
- java -jar trimmomatic-0.39.jar SE -threads 4 test_udemy.fastq test_trimmed.fastq TRAILING:10 -phred33
- hisat2 -q --rna-strandness R -x  grch38_genome/grch38/genome -U test_trimmed.fastq | samtools sort -o demo_trimmed.bam