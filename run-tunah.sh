#! /bin/bash

# TODO: remove this hardcoding
NUM_JOBS=12

# spawn jobs for each set
# NOTE: since this will be used as in index into an array, it needs to be 0..N-1
for i in $(seq 0 $(($NUM_JOBS-1)))
do
    oc process -f openshift/mlflow-experiment-job-template.yaml -p HYPERPARAM_SET_ID=$i | oc create -f -
done
