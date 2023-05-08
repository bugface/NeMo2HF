#!/bin/bash
# This script is used to automatically download mimic pretrained transformer models

mappings=("https://transformer-models.s3.amazonaws.com/mimiciii_bert_10e_128b.zip" \
	"https://transformer-models.s3.amazonaws.com/mimiciii_roberta_10e_128b.zip" \
	"https://transformer-models.s3.amazonaws.com/mimiciii_albert_10e_128b.zip" \
	"https://transformer-models.s3.amazonaws.com/mimiciii_deberta_10e_128b.tar.gz" \
	"https://transformer-models.s3.amazonaws.com/mimiciii_longformer_5e_128b.zip")

echo models pretrained on MIMIC-III corpus will be downloaded: 1. bert, 2. roberta, 3.albert, 4. deberta, 5.longformer

mkdir -p transformer_pretrained_models
cd transformer_pretrained_models

# in sagemaker studio we need to install unzip
if which unzip >/dev/null; then
    echo unzip exists
else
	echo unzip missing; we will try install via conda
    conda install unzip || exit 1
fi

for k in 0 1 2 3 4
do
	# wget ${mappings[${k}]}
	curl -O ${mappings[${k}]}

	# $(cut -d"." -f1 <<< $(cut -d"/" -f4 <<< ${mappings[${k}]}))

	model=$(cut -d"/" -f4 <<< ${mappings[${k}]})

	# mv $model transformer_pretrained_models

	if [ ${k} != 3 ]
	then
		unzip $model || exit 1
	else
		tar -xf $model --no-same-owner || exit 1
	fi

	rm -rf __MACOSX $model

	n=$(cut -d"." -f1 <<< $(cut -d"/" -f4 <<< ${mappings[${k}]}))

	echo $n is downloaded and unzip at $(pwd)/transformer_pretrained_models/${n}
done

cd -