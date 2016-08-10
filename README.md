# Example-Serial-SLURM
Example Code for Serial Batch Jobs using BatchJobs and BatchExperiments on LRZ Linux-Cluster

## First step: 

* Login to LRZ
* Clone repo: `git clone https://github.com/tobiriebe/Example-Serial-SLURM.git`


## Second step

* Start Jobs typing: `Rscript bmr.R`
* Get status using one of the following: 
   + `Rscript get_status.R`
   + `squeue -u $USER --clusters=serial`

## Third step

* `Rscript get_results.R`
