# Dataset Curation

Banna virus (BAV), classified under the genus Seadornavirus within the family Reoviridae, possesses a genome comprising 12 segments of double-stranded RNA (dsRNA), encoding a mix of structural and non-structural proteins. The total genome length is approximately 21 kb, with conserved terminal sequences that assist in genomic packaging and replication. First identified in Xishuangbanna, Yunnan Province, China, in 1987, BAV is transmitted by blood-sucking arthropods like mosquitoes, midges, and ticks. It infects a wide range of hosts, including humans, cattle, and swine, and has been associated with viral encephalitis and febrile illnesses. Its distribution spans Southeast Asia, with isolations from China, Vietnam, and Indonesia, highlighting its potential as a zoonotic pathogen.

Also included is a select virus also from the family Reoviridae: Kadipiro Virus (KDV).

**<ins>IMPORTANT NOTE:</ins>** Please install dependencies and set environment variables as described in the README (see "Installing a Local Copy of the Database") before running any of the shell scripts associated with these data.

### The Reference (and First Sequenced) Banna Virus Genome: JKT-6423

[Paper URL](https://pubmed.ncbi.nlm.nih.gov/10811934/) | [Dataset URL (JKT-6423 Banna virus)](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000858185.1/)

NCBI RefSeq Assembly: GCF_000858185.1

GenBank Assembly: GCA_000858185.1

NCBI (RefSeq) Segment Accessions (in order): NC_004211.1, 	NC_004217.1, 	NC_004218.1, 	NC_004219.1, 	NC_004220.1, 	NC_004221.1,    NC_004204.1, 	NC_004203.1, 	NC_004202.1, 	NC_004201.1, 	NC_004200.1, 	NC_004198.1

The first Bannavirus Genome was sequenced in 2000 (H Attoui, et al.). ***#TODO: explanation***

![JKT-6423 JBrowse View](images/JKT-6423-view.png)

To include this sequence in your copy of the database:
```bash
bash ./scripts/jkt_6423.sh
```

or, if you don't have bash installed: 
```bash
chmod +x scripts/jkt_6423.sh # you may need to run `sudo chmod +x scripts/jkt_6423.sh`
./scripts/jkt_6423.sh
```

For the rest of this database setup guide we'll reference the upper instruction, but know that the lower instruction can still be applied (with a different file name).

### Another Full Banna Virus Genome (Alternate Strain - BAV-Ch): 

[Dataset URL (BAV-Ch)](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_023156985.1/)

GenBank Assembly: GCA_023156985.1

GenBank Segment Accessions (in order): 	AF168005.1, 	AF134526.1, 	AY549307.1, 	AY549308.1, 	AY549309.1, 	AF168006.1, 	AF052035.1, 	AF052034.1, 	AF052033.1, 	AF052032.1, 	AF052031.1, 	AF052030.1

***#TODO: explanatione***

![BAV-Ch JBrowse View](images/BAV-Ch-view.png)

To include this sequence in your copy of the database:
```bash
bash ./scripts/bav-ch.sh
```

### Comparison to Kadipiro Virus

[Paper URL](https://pubmed.ncbi.nlm.nih.gov/10811934/) | [Dataset URL (KDV)](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000851685.1/)

NCBI RefSeq Assembly: GCF_000851685.1

GenBank Assembly: GCA_000851685.1 (incomplete)

NCBI (RefSeq) Segment Accessions (in order): NC_004210.1, 	NC_004212.1, 	NC_004213.1, 	NC_004214.1, 	NC_004215.1, 	NC_004216.1, 	NC_004209.1, 	NC_004208.1, 	NC_004207.1, 	NC_004206.1, 	NC_004205.1, 	NC_004199.1

***#TODO: explanation***

![KDV JBrowse View](images/KDV-JKT-7075-view.png)

To include this sequence in your copy of the database:
```bash
bash ./scripts/kdv_jkt_7075.sh
```

***#TODO: syntenty view? some alignment view, at least***


### MSA Analysis of Least Conserved Segments

[Paper URL](https://pmc.ncbi.nlm.nih.gov/articles/PMC10687475/) | [Dataset URL ()]()

### Vietnam/China virus clustering?

[Paper URL](https://pmc.ncbi.nlm.nih.gov/articles/PMC2600385/)


### Protein Structures

[Paper URL](https://pmc.ncbi.nlm.nih.gov/articles/PMC10687475/) | [Dataset URL ()]()

### Citations (Datasets)

1. 
2. 
