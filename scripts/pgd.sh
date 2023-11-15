#!/usr/bin/env bash
#SBATCH --time=23:59:59
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=gpu
#SBATCH --gres=gpu:4
#SBATCH --mem=230G
#SBATCH --cpus-per-task=64
#SBATCH --output=slurm/tmlr/pgd_%A.out
#SBATCH --error=slurm/tmlr/pgd_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shashank.agnihotri@uni-siegen.de

#reload
#sttr
#module unload pytorch-py37-cuda11.2-gcc8/1.9.1
#pip install typing-extensions

CUDA_VISIBLE_DEVICES=0
python main_fgsm.py  --epochs 15\
                --batch_size 1\
                --checkpoint $7\
                --pre_train\
                --num_workers 8\
                --dataset sceneflow\
                --dataset_directory data/SCENE_FLOW\
                --kernel_size $4\
                --para_kernel_size $5\
                --resume $6\
                --eval\
                --fgsm\
                --epsilon $2\
                -it $1\
                -at pgd\
                --alpha $3

