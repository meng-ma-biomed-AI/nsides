#!/bin/bash

tar xvfz nsides_test.tgz


/usr/local/bin/pip install --user h5py
/usr/local/bin/pip install --user keras

# Run the script 
cd keras_models
python prepare_data.py --model-number $1
python prepare_data_separate_reports.py --model-number $1
python mlp_dnn.py --run-on-cpu --model-number $1
python mlp_otherClf.py -v --run-comparisons --run-on-cpu --model-number $1

# Clean up the data on the remote machine 
cd ..
rm nsides_test.tgz
rm -rf keras_models/AEOLUS*.npy
rm -rf keras_models/all_mrns.npy
rm -rf keras_models/all_ages.npy
tar cvfz keras_out_$1.tgz keras_models