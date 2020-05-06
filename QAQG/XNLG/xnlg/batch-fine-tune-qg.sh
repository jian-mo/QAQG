#!/bin/bash
#SBATCH --account=def-lulam50
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4           # Number of GPUs (per node)
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --mem=30G                  # memory (per node)
#SBATCH --time=0-020:00            # time (DD-HH:MM)
#SBATCH --mail-user=jian.mo.1@ulaval.ca
#SBATCH --mail-type=FAIL

date
SECONDS=0

source ../ENV/bin/activate
module load java/1.8.0_192

python xnlg-ft.py --exp_name xqg --dump_path ../dump --model_path ../data/model/en-fr-zh_valid-en-fr.pth --data_path ../data/processed/XNLG --transfer_tasks XQG --optimizer adam,lr=0.000005 --batch_size 16 --n_epochs 200 --epoch_size 4000 --max_len_q 256 --max_len_a 20 --max_len_e 230 --max_vocab 95000 --train_layers 1,10                     --vocab_path ../data/xqg-decoding-vocab --decode_with_vocab True                 --decode_vocab_sizes 95000,95000,95000 --n_enc_layers 10 --n_dec_layers 6 --beam_size 3 --ds_name xqg --train_directions fr-fr --eval_directions fr-fr,en-en

diff=$SECONDS
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
date