#!/usr/bin/env bash
# run fine-tuning
BASEDIR=/scratch/mojians/scientific/QAQG/unilm/
DATA_DIR=qg_data/train
OUTPUT_DIR=output/
MODEL_RECOVER_PATH=model/unilmv1-large-cased.bin

source $HOME/ENV/bin/activate

ssh beluga4 -L 8000:s3.amazonaws.com:80 -N -f
#sshuttle --dns -Nr mojians@beluga4

#export CUDA_VISIBLE_DEVICES=0,1,2,3,4

#--fp16 --amp --loss_scale 0   for apex training
python ${BASEDIR}/src/biunilm/run_seq2seq.py  --do_train  --num_workers 0   --bert_model bert-large-cased --new_segment_ids --tokenized_input   --data_dir \
${BASEDIR}/qg_data/train --src_file train.pa.tok.txt --tgt_file train.q.tok.txt   --output_dir ${BASEDIR}/output/bert_save  \
--log_dir ${BASEDIR}/output/bert_log   \
--model_recover_path ${BASEDIR}/model/unilmv1-large-cased.bin   --max_seq_length 512 --max_position_embeddings 512   --mask_prob 0.7 --max_pred 48   --train_batch_size 25 \
--gradient_accumulation_steps 2   --learning_rate 0.00002 --warmup_proportion 0.1 --label_smoothing 0.1   --num_train_epochs 12 \
#--fp16 --amp

export PYTORCH_PRETRAINED_BERT_CACHE=cache/bert-cased-pretrained-cache