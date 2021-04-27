## Run the CERR implementation with optional oct2py bridge in a docker container

Idea: A few lines of python code invoke a matlab function (`radiomic_and_dosimetric_feature_extraction`), where the sampleData is pushed
into the octave instance prior to running, or in a local folder bind-mounted to container.

Scripts exist at /ana/ within the container.

### Python-based container (no CUDA support)
To build: `docker build . --tag msk-mind-cerr:python`

To run: `docker run -it msk-mind-cerr:python`

### CUDA-enabled container for DL segmentation
To build: `docker build --file docker_cudnn --tag msk-mind-cerr:cudnn`

To run Octave script segmentation demo: `docker run --rm -v `pwd`/data:scratch msk-mind-cerr:cudnn octave /ana/demo_runSegForPlanC.m`

To run oct2py-based segmentation demo: `docker run --rm -v `pwd`/data:/scratch msk-mind-cerr:cudnn python /ana/run_dlseg.py`

Run Octave CLI interactively from container: `docker run --rm -v `pwd`/data:/scratch msk-mind-cerr:cudnn octave`
