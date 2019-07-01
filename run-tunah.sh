#! /bin/bash

# path to training/hyperparam-tuning project.
# if not passed as cmd line arg. use default
# WARNING: You will have to change default according to your project
TRAIN_DIR=${1-"/home/kachauha/Documents/training"}

# determine number of jobs (one per hyperparam combination)
NUM_JOBS=$(grep -cow "hyperparam_set" "$TRAIN_DIR/hyperparameters.yml")

# spawn jobs for each set
# NOTE: since this will be used as in index into an array, it needs to be 0..N-1
for i in $(seq 0 $(($NUM_JOBS-1)))
do
    oc process -f openshift/mlflow-experiment-job-template.yaml -p HYPERPARAM_SET_ID=$i | oc create -f -
done
