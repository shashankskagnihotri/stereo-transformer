#!/bin/bash

epsilon="0.03"
alpha="0.01"
iterations="3 5 10 20 40"
targted="True False"
attacks="cospgd pgd"

for target in $targeted 
do
	for attack in $attacks
	do

		for it in $iterations
		do
			#sttr
			job_name="STTR_m_${attack}_${it}_${target}"
			ckpt="STTR_m_${attack}_${target}"
			sbatch -J ${job_name} --output "slurm/neurips/${job_name}.out" --error "slurm/neurips/${job_name}.err" scripts/multi_step_cospgd.sh $epsilon $alpha $it $attack $target ${ckpt}
		done
	done
done