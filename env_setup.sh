#!/usr/bin/env bash
singularity pull docker://tensorflow/tensorflow:latest-gpu-jupyter
singularity exec tensorflow_latest-gpu-jupyter.sif echo "hello,dinosaur"
singularity shell -B /localscratch:/localscratch/ tensorflow_latest-gpu-jupyter.sif
singularity pull docker://mojians/cc_singularity

#allocate resource
salloc -N 1 -t 00:10:00
#https://www.sdsc.edu/education_and_training/tutorials1/singularity.html

#machine learning
salloc --account=def-lulam50 --gres=gpu:4 --cpus-per-task=6 --mem=32000M --time=60:00
#T4 on graham
salloc --account=def-lulam50 --gres=gpu:t4:2 --cpus-per-task=6 --mem=32000M --time=60:00
#v100 on graham
salloc --account=def-lulam50 --gres=gpu:v100:8 --cpus-per-task=6 --mem=32000M --time=60:00

virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/bin/activate
pip install --no-index --upgrade pip

https://docs.computecanada.ca/wiki/Tutoriel_Apprentissage_machine/en

# show job status
scontrol show job -dd 3550953  #job id
squeue -u $USER

#default login node
ssh mojians@beluga3