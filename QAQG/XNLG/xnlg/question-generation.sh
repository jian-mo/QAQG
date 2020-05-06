#!/usr/bin/env bash
source ../ENV/bin/activate
##../dump/xqg/4758714/best_en-en_Bleu_4qe.pth
module load         java/1.8.0_192
#--vocab_path  ../data/xqg-decoding-vocab
ssh beluga4 -L 12345:localhost:12345 -N -f
python qg.py  --data_path  ../data/processed/XNLG/ --model_dir  ../dump/xqg/  --job_name en-en  --direction en-en --model_path ../dump/xqg/4790453/best_en-en_Bleu_4.pth --out_dir ../dump/qg_out/ --decode_with_vocab True --vocab_path  ../data/xqg-decoding-vocab