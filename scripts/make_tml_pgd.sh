#!/usr/bin/env bash

kernel_sizes="3 7 11"
para_kernel_sizes="3"
iterations="5 10 20 40"
epsilon="0.03"
alpha="0.01"
path="pretrained_models/pretrained_models/vanilla/model.pth.tar"
checkpoint="tmlr_attack_"

for kernel_size in $kernel_sizes
do
    if [[ kernel_size = "3" ]]
    then
        para_kernel_size="0"
    else
        para_kernel_size="0 3"
    fi

    for para_kernel_size in $para_kernel_sizes
    do
        if [[ kernel_size = "7" ]]
        then
            if [[ para_kernel_size = "0" ]]
            then
                path="pretrained_models/pretrained_models/trans_7/model.pth.tar"
            else
                path="pretrained_models/pretrained_models/trans_7_3/model.pth.tar"
            fi
        elif [[ kernel_size = "11" ]]
        then
            if [[ para_kernel_size = "0" ]]
            then
                path="pretrained_models/pretrained_models/trans_11/model.pth.tar"
            else
                path="pretrained_models/pretrained_models/trans_11_3/model.pth.tar"
            fi
        else
            path="pretrained_models/pretrained_models/vanilla/model.pth.tar"
        fi

        for iteration in $iterations
        do
            checkpoint="tmlr_pgd_attack_ks_${kernel_size}_pks_${para_kernel_size}_itr_${iteration}_eps_${epsilon}_alpha_${alpha}"
            sbatch scripts/pgd.sh $iteration $epsilon $alpha $kernel_size $para_kernel_size $path $checkpoint
        done
    done
done
