Gene Burden Pipeline Dependency Apptainer Container
-------
  README Last modified 8/14/25 by Jyoti Lama
-------
  FOLDER CONTENTS
--
  This folder contains an apptainer container file with the dependencies for the group Gene Burden pipeline as well as related files.

GeneBurdenCondaEnv.yaml  - File for building a conda environment containing the apptainer dependencies
README  - This file
GBpipeline.def  - The apptainer definition file used to generate the container file
GBpipeline.sif  - The container file containing the dependencies

-------
  CONDA ENVIRONMENT
--
  While the container has most of the dependencies needed to run the Gene Burden pipeline, the container
itself also has some dependencies. You can build the necessary environment with

conda env create -f GeneBurdenCondaEnv.yaml

The default environment name is "GeneBurdenContainer".

-------
  EXECUTING COMMANDS
---
  
  To run commands within the container:
  
  apptainer exec --bind <comma separated list of directories your command needs access to> GBpipeline.sif <command>
  example- apptainer exec --bind /data/GeneBurdenPipeline/workdir/ GBpipeline.sif nextflow run step2_to_7.nf -params-file step2.params.yaml -with-report report.html -with-trace trace.txt
  
  Make sure to activate the conda environment from the .yaml file before running your command.

-------
  WARNINGS
---
  The current version of the container results in some warnings that do not appear to impede the functionality of the pipeline. If you notice a warning that you think does not fall into this category, please let us know and we will endeavor to fix it.

----
  Building containers
  
  module load apptainer
  apptainer build --fakeroot GBpipeline.sif GBpipeline.def
  source activate GeneBurdenContainer
  
