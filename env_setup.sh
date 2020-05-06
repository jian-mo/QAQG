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

#gpu on niagra mist
ssh -Y mist-login01
salloc --account=def-lulam50 --gpus-per-node=4  --nodes=1 --time=180:00 --partition=compute_full_node


virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/bin/activate
pip install --no-index --upgrade pip

https://docs.computecanada.ca/wiki/Tutoriel_Apprentissage_machine/en

# show job status
scontrol show job -dd 3550953  #job id
squeue -u $USER

#default login node
ssh mojians@beluga3

#reverse debug
ssh -R 12345:localhost:12345 mojians@beluga.calculcanada.ca
ssh -R 12345:localhost:12345 mojians@mist.scinet.utoronto.ca


#add code in script
import pydevd_pycharm

pydevd_pycharm.settrace('localhost', port=12345, stdoutToServer=True,
                         stderrToServer=True)

#cp from mist to beluga
scp optim.15.bin mojians@beluga.calculcanada.ca:/home/mojians/projects/def-lulam50/mojians/scientific/QAQG/unilm/output/double_s2s
#from beluga to mist
scp model.7.bin mojians@mist.scinet.utoronto.ca:/scratch/l/lulam50/mojians/scientific/QAQG/unilm/output/double_s2s
