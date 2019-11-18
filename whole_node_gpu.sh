#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gres=gpu:lgpu:4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24    # There are 24 CPU cores on Cedar GPU nodes, 40 on Beluga
#SBATCH --mem=0               # Request the full memory of the node
#SBATCH --time=3:00
#SBATCH --account=def-lulam50
hostname
nvidia-smi