

# Steps for FunCore

## Data selection
To select the data for FunCore analyses.

1. Copy the fungl table from [JGI MycoCosm](https://mycocosm.jgi.doe.gov/fungi/fungi.info.html).
2. Organise the data and manually select
   * published
   * had permission (old one)
   * one genome per species (new one)
> Script: table_organise.r

3. Get the abbreviation from JGI url
>  Script: web_for_abbr.r
>  Data: 20240805_merge_list.csv

4. Download data from JGI by its abbreviation
> Script: for_jgi.r, jgi-query.sh
>> may need to recheck the fail log a few times

5. zcat all genome data
```bash
zcat *.aa.fasta.gz > 20240814_FunCore.aa.fasta.gz
```

### Fungal tree of life
1. Copy the fungl table from [JGI MycoCosm Tree](https://mycocosm.jgi.doe.gov/mycocosm/home) by each clade.
2. Merge the FunCore data and calculate the number of species, genome size, and number of genes by each clade.
> Script: tree.r
> Data: 20240814_merge_tree.csv
  
3. plot the figures by Prism.
> File: FunCore (sheet: JGI_tree_species, JGI_tree_genome_size, and JGI_tree_gene)

## Paired wise comparison