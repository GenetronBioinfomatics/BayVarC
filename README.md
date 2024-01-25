# BayVarC

 

## Overview

BayVarC, a novel variant caller specifically designed for variant calling in liquid biopsy. It applies Bayesian inference to accurately quantify noise level in a locus specific manner, enabling the discrimination between technical noise and low-frequency cancer variants. Nevertheless, wet lab environment varies between laboratories and our evaluation cannot be exhaustive. To fully exploit BayVarC’s strength, we encourage users to train BayVarC error model based on their own experimental environment. During the error modeling, BayVarC applied a Bayesian inference which allows it to train using limited samples while ensure accurate estimation of locus specific error. Then, BayVarC compares the observed signal, indicative of candidate variant, against the posterior error rate as defined by the model. Subsequently, BayVarC employs Binomial testing at predefined significance level (alpha) to determine the nature of observed signal.

 

## Requirements

- Python 3.7

- Numpy >=1.16

- Pandas >=0.23

- Samtools >=1.7

- Scipy

- Bedtools

To see the help for the program, run:

```shell
<path_to_bayvarc_folder>/bin/BayVarC-Model -h

<path_to_bayvarc_folder>/bin/BayVarC -h
```

 

## Getting start

### Error model generation with limited training samples(N>=40)

To train BayVarC error model based on their own experimental environment, the following is an example command to run:

```shell
<path_to_bayvarc_folder>/bin/BayVarC-Model -c <training.sample.list> -p <model_prefix> -cut <frequency_cutoff> -m <mappability.features.file> -t <trinucleotide.feature.file> -r <repeats.feature.file> -s <segmentDup.feature.file> -o <output_to_path> 
```

The model generation test script is stored in file `Create_model_test.sh`. The input data of tests is stored in folder `Input data/` directory. The output model of the tests can be viewed in the `output data/` directory, the position-specific error is store in file `SNV_Model/<model_prefix> _snvs.posterior.xls` and `InDel_Model/<model_prefix> _indels.posterior.xls` respectively.

 

### Variants calling pipeline

To run variant caller pipeline from mpileup file, BayVarC employs Binomial testing at predefined significance alpha to determine the observed signal, the following is an example command to run:

```shell
<path_to_bayvarc_folder>/bin/BayVarC -i <mpileupfile> -s <sample> -m <error_model_dir> -p <error_model_prefix> -a <significance_level> -ins <insertion_length_threshold> -del <deletion_length_threshold> -d <minimum_total_depth> -c <minimum alt reads> -f <minimum mismatch frequency> -r <reference_file> -n <ncpu> -o <output_to_path>
```

The variants calling test script is stored in file `Variant_calling_test.sh`. The output model of the tests can be viewed in the `output data/` directory, the mutations with ‘**PASS**’ is accept as a confident somatic mutation in `*filter.vcf` files.

 

## File format for BayVarC-Model

### Training file list

For each sample, you can use samtools mpileup to generate the mpileup file and then trans to position-specific format statistic file for BayVarC-Model. The file format as follows:

```
CHR    POSITION  DEPTH REF    A   C   T   G
5   1295018 2089   T   7   0   0   10
5   1295019 2114   G  13  0   4   0
```

### Features file

`<trinucleotide.feature.file>` 

Each line include 4 columns, chromosome, position, reference and tri-nucleotide context. Tri-nucleotide context can be extracted from genome file. The file format as follows:

```
CHR    POSITION  REF    TNT	
5   1295018 C   GCC
5   1295019 C   CCG
```

`<mappability.feature.file>` 

Each line include 4 columns, chromosome, position, reference and mappability tracks form UCSC, ,The file format as follows:

```
CHR    POSITION  REF    ABI
5   1295018 C   1
5   1295019 C   1
```

`<repeats.feature.file>`

Each line include 4 columns, chromosome, position, reference and repeats elements form UCSC, The file format as follows:

```
CHR    POSITION  REF    RepeatsMask
5   1295018 C   NonRepeats
5   1295019 C   NonRepeats
```

`<segmentDup.feature.file>` 

Each line include 4 columns, chromosome, position, reference and segmental duplication form UCSC, The file format as follows:

```
CHR    POSITION  REF    SegmentDup
5   1295018 C   NonSegDup
5   1295019 C   NonSegDup
```

The whole genome feature files can be download from UCSC and then use ‘bedtools intersect’ command to extract position-specific features according to BED files.

## License

The code is freely available under the [GNU license](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Contact

Dongxue Che

Cheng Yan

Yufei Yang

 
