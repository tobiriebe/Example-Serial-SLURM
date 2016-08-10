# Example-Serial-SLURM
Example Code for Serial Batch Jobs using BatchJobs and BatchExperiments on LRZ Linux-Cluster

## First step: 

* Login to LRZ
* Clone repo: `git clone https://github.com/philippstats/Example-Serial-SLURM.git`
* In bmr.R adjust setwd in line 9.
* In lrz_serial.tmpl update the email in line 32. 

## Second step

* Start Jobs typing: `Rscript bmr.R`
* Get status using one of the following: 
   + `Rscript get_status.R`
   + `squeue -u $USER --clusters=serial`

## Third step

* `Rscript get_results.R`
