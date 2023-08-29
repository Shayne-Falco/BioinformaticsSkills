#Notes
#Sequencing your own data: the sequencing facility will almost always provide fastq files.
#For publicly available sequence data from GEO/SRA, the files are usually in the Sequence Read Archive (SRA) format. 
#Prior to read alignment, these files need to be converted into the FASTQ format using the fastq-dump utility from the SRA Toolkit. 
#See http: //www.ncbi.nlm.nih.gov/books/NBK158900 for how to download and use the SRA Toolkit.
#By default, alignment is performed with unique=TRUE. 
#If a read can be aligned to two or more locations, Rsubread will attempt to select the best location using a number of criteria. 
#Only reads that have a unique best location are reported as being aligned. Keeping this default is recommended, as it avoids spurious signal from non-uniquely mapped reads derived from, e.g., repeat regions.
#featureCounts requires gene annotation specifying the genomic start and end position of each exon of each gene. Rsubread contains built-in gene annotation for mouse and human.
#For other species, users will need to read in a data frame in GTF format to define the genes and exons. Users can also specify a custom annotation file in SAF format. 
#See the Rsubread users guide for more information, or try ?featureCounts, which has an example of what an SAF file should like like.




#downloading aligner
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rsubread")

#check what the working directory is
getwd()

#set working directory as your project folder


#call for alignment package
library(Rsubread)

#all the seq files are in R project.
#We need to find them in order to tell Rsubread aligner which files to look at. 
#we use list.files command to look for all.fastq.gz files for this.
fastq.files <- list.files(path = "C:/Users/Anupama Rao/Documents/R project", pattern = ".fastq.gz$", full.names = TRUE)
fastq.files

#building an index (this one here is for mouse chr. 1)
#The command assumes the chr1 genome info for mm10 is stored in the "chr1.fa" file.
buildindex(basename="chr1_mm10",reference="chr1.fa")

#aligning reads to reference genome
align("chr1_mm10", readfile1= fastq.files)

#to examine alignment parameters
args(align)

#summary of the proportion of reads that mapped to the reference genome.
bam.files <- list.files(path = "C:/Users/Anupama Rao/Documents/R project", pattern = ".BAM$", full.names = TRUE)
bam.files

props <- propmapped(files=bam.files)
props

# Extract quality scores
qs <- qualityScores(filename="C:/Users/Anupama Rao/Documents/R project/SRR1552450.fastq.gz",nreads=100)
# Check dimension of qs
dim(qs)
# Check first few elements of qs with head
head(qs)

#To look at the overall distribution of quality scores across the 100 reads: boxplot
boxplot(qs)

#counting reads mapped to genes
fc <- featureCounts(bam.files, annot.inbuilt="mm10")

# See what slots are stored in fc
names(fc)

# Take a look at the featurecounts stats
fc$stat

# Take a look at the dimensions to see the number of genes
dim(fc$counts)

# Take a look at the first 6 lines
head(fc$counts)

head(fc$annotation)