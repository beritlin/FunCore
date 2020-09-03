#!/bin/bash

TARGET=/work1/home/peiyu/FunCore/upload
PROCESSED=/work1/home/peiyu/FunCore/output

inotifywait -m -e create -e moved_to --format "%f" $TARGET \
        | while read FILENAME
                do
                        echo Detected $FILENAME
                        /work1/home/peiyu/FunCore/MMseqs2/build/bin/mmseqs easy-search "$TARGET/$FILENAME" /work1/home/peiyu/FunCore/allfungi.fasta Output.m8 tmp
                        Rscript cluster_compared.R
                        mysql -u user -p 27871139  FunCore < database.sql
                done