#!/usr/bin/env bash

DATA_DIR=qg_data/test
MODEL_NAME=$2
MODEL_EPOCH=$3
MODEL_RECOVER_PATH=output/${MODEL_NAME}/model.${MODEL_EPOCH}.bin
EVAL_SPLIT=dev
OUTPUT_DIR=output/decode
MODE=$4
if [ "$4" = "a2q" ]; then
    DATASET="pa"
elif [ "$4" = "q2a" ]; then
    DATASET="pq"
else
    DATASET="pa"
fi

if [ "$1" = "beluga" ]; then
    echo beluga activated
    echo "mode:"${MODE}
    echo "model_name:"${MODEL_NAME}

    BASEDIR=/home/mojians/projects/def-lulam50/mojians/scientific/QAQG/unilm/
    source $HOME/ENV/bin/activate
    ssh beluga3 -L 8000:s3.amazonaws.com:80 -N -f
    ssh beluga3 -L 12346:localhost:12346 -N -f
    cp src/pytorch_pretrained_bert/modeling.py /scratch/mojians/scientific/QAQG/unilm/src/pytorch_pretrained_bert/modeling.py

elif [ "$1" = "niagara" ];then
    echo "niagara activated"
    echo "mode:"${MODE}
    BASEDIR=/scratch/l/lulam50/mojians/scientific/QAQG/unilm/
#    cp ${BASEDIR}src/pytorch_pretrained_bert/modeling.py /home/l/lulam50/mojians/scientific/QAQG/unilm/src/pytorch_pretrained_bert/modeling.py -y

    conda activate torch
    ssh mist-login01 -L 8000:s3.amazonaws.com:80 -N -f
#    ssh mist-login01 -L 12345:localhost:12345 -N -f
 fi

export PYTORCH_PRETRAINED_BERT_CACHE=cache/bert-cased-pretrained-cache
#cp modeling
# run decoding
date
python src/biunilm/decode_seq2seq.py --bert_model bert-large-cased --new_segment_ids --mode ${MODE} \
  --input_file ${DATA_DIR}/dev.${DATASET}.tok.txt --split ${EVAL_SPLIT} --tokenized_input \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 512 --max_tgt_length 60 \
  --batch_size 64 --beam_size 10 --length_penalty 0 \
  --output_file ${OUTPUT_DIR}/decode_${MODEL_NAME}_${MODE}_${MODEL_EPOCH}.txt \


#  --fp16 --amp
# run evaluation using our tokenized data as reference
#python src/qg/eval_on_unilm_tokenized_ref.py --out_file src/qg/output/qg.test.output.txt
## run evaluation using tokenized data of Du et al. (2017) as reference
#python src/qg/eval.py --out_file src/qg/output/qg.test.output.txt