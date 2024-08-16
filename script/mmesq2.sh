## homology search
/work1/home/peiyu/tools/MMseqs2/build/bin/mmseqs  createdb 20240814_FunCore.aa.fasta.gz queryDB
/work1/home/peiyu/tools/MMseqs2/build/bin/mmseqs  createindex queryDB tmp
/work1/home/peiyu/tools/MMseqs2/build/bin/mmseqs  search queryDB queryDB resultDB tmp   -e 0.00001 --min-seq-id 0.5
/work1/home/peiyu/tools/MMseqs2/build/bin/mmseqs  convertalis queryDB queryDB resultDB 20240808_resultDB.m8