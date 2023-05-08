#! bin/bash
# This script is used to automatically download and convert Gatortron-og-345m model to your local
# require torch and transformers packages installed

wget --content-disposition https://api.ngc.nvidia.com/v2/models/nvidia/clara/gatortron_og/versions/1/zip \
	-O gatortron_og_1.zip

mkdir gatortron_og
mv gatortron_og_1.zip gatortron_og/gatortron_og_1.zip
cd gatortron_og

unzip gatortron_og_1.zip

wget https://raw.githubusercontent.com/huggingface/transformers/main/src/transformers/models/megatron_bert/convert_megatron_bert_checkpoint.py

git clone https://github.com/NVIDIA/Megatron-LM

PYTHONPATH=Megatron-LM python convert_megatron_bert_checkpoint.py $(pwd)/MegatronBERT.pt

rm -rf MegatronBERT.* hparam.yaml Megatron-LM convert_megatron_bert_checkpoint.py gatortron_og_1.zip

echo download the gatortron-og model at ${pwd}

cd -