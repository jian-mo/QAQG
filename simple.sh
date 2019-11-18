#!/bin/bash
#SBATCH --gres=gpu:1              # Number of GPU(s) per node
#SBATCH --cpus-per-task=6         # CPU cores/threads
#SBATCH --mem=4000M               # memory per node
#SBATCH --time=0-03:00            # time (DD-HH:MM)
#SBATCH --account=def-lulam50
echo 'Hello, world!'
sleep 30

