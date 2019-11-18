#!/usr/bin/env bash

BASEDIR=/scratch/mojians/scientific/QAQG/unilm/
DATA_DIR=qg_data/test
MODEL_RECOVER_PATH=model/model.12.bin
EVAL_SPLIT=test
OUTPUT_DIR=output/

source $HOME/ENV/bin/activate
ssh beluga4 -L 8000:s3.amazonaws.com:80 -N -f

export PYTORCH_PRETRAINED_BERT_CACHE=cache/bert-cased-pretrained-cache
# run decoding
python src/biunilm/decode_seq2seq.py --bert_model bert-large-cased --new_segment_ids --mode s2s \
  --input_file ${DATA_DIR}/test.pa.tok.txt --split ${EVAL_SPLIT} --tokenized_input \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 512 --max_tgt_length 48 \
  --batch_size 16 --beam_size 1 --length_penalty 0 \
  --output_file ${OUTPUT_DIR}/decode_12.txt \
#  --fp16 --amp
# run evaluation using our tokenized data as reference
#python src/qg/eval_on_unilm_tokenized_ref.py --out_file src/qg/output/qg.test.output.txt
## run evaluation using tokenized data of Du et al. (2017) as reference
#python src/qg/eval.py --out_file src/qg/output/qg.test.output.txt