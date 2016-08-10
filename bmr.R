# Benchmarks

library(mlr)
library(BatchJobs)
library(BatchExperiments)
library(dplyr)

# modify the next line:
setwd("/naslx/projects/ua341/di25kaq/Benchmarks/bmrserial")

loadConfig()
getConfig()
reg = makeExperimentRegistry("bmrserial", packages = "mlr")

#
# Problem
#

tasks = list(pid.task = pid.task) 

for (i in seq_along(tasks)) {
  tk = tasks[[i]]
  static = list(task = tk)
  addProblem(reg, id = getTaskId(tk), 
    static = static, 
    dynamic = function(static) {
      rdesc = makeResampleDesc("CV", iters = 5, stratify = TRUE)
      rin = makeResampleInstance(desc = rdesc, task = static$task)
      list(rin = rin)
    }, 
  seed = i, overwrite = TRUE)
}


#
# Algorihm GBM
#


addAlgorithm(reg, 
  id = "GBM", 
  fun = function(static, dynamic, n.trees) {
    configureMlr(on.learner.error = "warn")
    lrn = makeLearner("classif.gbm", predict.type = "prob", 
      fix.factors.prediction = TRUE, par.vals = list(n.trees = n.trees))
  
    r = resample(learner = lrn, task = static$task, resampling = dynamic$rin,
      measures = list(mmce, auc), models = TRUE)
    print(r)
    r
  },
  overwrite = TRUE
)

n.trees = seq(100L, 1000L, length.out = 10L)
design = makeDesign("GBM", exhaustive = list(n.trees = n.trees))
addExperiments(reg, rep = 3, algo.designs = design)

#
# Summarize
#

summarizeExperiments(reg)


#
# Submit
#

# resources for serial are: walltime, memory
submitJobs(reg, resources = list(walltime = 60L*60L*1L, memory = 1000L), max.retries = 10L)
