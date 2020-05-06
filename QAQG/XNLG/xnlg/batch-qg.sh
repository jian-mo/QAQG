#!/bin/bash
#SBATCH --account=def-lulam50
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4           # Number of GPUs (per node)
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --mem=10G                  # memory (per node)
#SBATCH --time=00-00:60            # time (DD-HH:MM)
#SBATCH --mail-user=jian.mo.1@ulaval.ca

date
SECONDS=0
source ../ENV/bin/activate
##../dump/xqg/4758714/best_en-en_Bleu_4qe.pth
module load java/1.8.0_192
python qg.py  --data_path  ../data/processed/XNLG/ --model_dir  ../dump/xqg/  --job_name en-fr  --direction en-fr --model_path ../dump/xqg/4790453/best_en-en_Bleu_4.pth --out_dir ../dump/qg_out/ --decode_with_vocab True --vocab_path  ../data/xqg-decoding-vocab

diff=$SECONDS

echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
date