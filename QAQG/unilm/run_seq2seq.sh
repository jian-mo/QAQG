#!/usr/bin/env bash
# run fine-tuning
#for niagara



if [ "$1" = "niagara" ]; then
    echo "niagara selected"
    ssh mist-login01 -L 8000:s3.amazonaws.com:80 -N -f

    if [ "$3" = "debug" ]; then
        ssh mist-login01 -L 12346:localhost:12346 -N -f
    fi

    BASEDIR=/scratch/l/lulam50/mojians/scientific/QAQG/unilm/
    echo ${BASEDIR}

elif [ "$1" = "beluga" ]; then
    BASEDIR=/home/mojians/projects/def-lulam50/mojians/scientific/QAQG/unilm/
    source ~/ENV/bin/activate

    ssh beluga1 -L 8000:s3.amazonaws.com:80 -N -f
    #remote debug
    if [ "$3" = "debug" ]; then
        ssh beluga1 -L 12346:localhost:12346 -N -f
    fi
fi

DATA_DIR=${BASEDIR}/qg_data/train
OUTPUT_DIR=output/
MODEL_RECOVER_PATH=model/unilmv1-large-cased.bin

MODE=$2


SRC="pa"
TGT="q"

#sshuttle --dns -Nr mojians@beluga4

#export CUDA_VISIBLE_DEVICES=0,1,2,3,4

#cp modeling
#cp src/pytorch_pretrained_bert/modeling.py /scratch/mojians/scientific/QAQG/unilm/src/pytorch_pretrained_bert/modeling.py


#--fp16 --amp --loss_scale 0   for apex training
python ${BASEDIR}/src/biunilm/run_seq2seq.py  --do_train  --mode ${MODE} --num_workers 1   --bert_model bert-large-cased --new_segment_ids --tokenized_input   --data_dir \
${DATA_DIR} --src_file train.${SRC}.tok.txt --tgt_file train.${TGT}.tok.txt   --output_dir ${BASEDIR}/output/${MODE}  \
--log_dir ${BASEDIR}/output/bert_log   \
--model_recover_path ${BASEDIR}/model/unilmv1-large-cased.bin   --max_seq_length 512 --max_position_embeddings 512   --mask_prob 0.7 --max_pred 48   --train_batch_size 64 \
--gradient_accumulation_steps 8   --learning_rate 0.00002 --warmup_proportion 0.1 --label_smoothing 0.1   --num_train_epochs 20 \
--fp16 --amp
#--fp16 --amp --loss_scale 0

export PYTORCH_PRETRAINED_BERT_CACHE=cache/bert-cased-pretrained-cache