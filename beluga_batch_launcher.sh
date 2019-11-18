#!/bin/bash
#SBATCH --account=def-lulam50
#SBATCH --cpus-per-task=14
#SBATCH --gres=gpu:4              # Number of GPUs (per node)
#SBATCH --mem=30G                  # memory (per node)
#SBATCH --time=0-010:00            # time (DD-HH:MM)
#SBATCH --mail-user=jian.mo.1@ulaval.ca
#SBATCH --mail-type=FAIL
source $HOME/ENV/bin/activate

date
SECONDS=0

# real script here
sh QAQG/unilm/run_seq2seq.sh

diff=$SECONDS
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
date