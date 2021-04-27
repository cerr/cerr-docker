# cerr-docker

## Run the CERR implementation with optional oct2py bridge in a docker container

Idea: A few lines of python code invoke matlab/octave functions (`radiomic_and_dosimetric_feature_extraction`, `demo_runSegForPlanC`), where the sampleData is pushed
into the octave instance prior to running, or contained in a local folder bind-mounted to container.

Scripts exist at /ana/ within the container.

### Python-based container (no CUDA support) for radiomics analysis
To build: `docker build . --tag msk-mind-cerr:python`

To run: `docker run -it msk-mind-cerr:python`

### CUDA-enabled container for DL segmentation
To acquire the DL model files used in this demo, please contact: [apte@mskcc.org](mailto:apte@mskcc.org)

To build: `docker build --file docker_cudnn --tag cerr-octave:cudnn`

To run Octave script segmentation demo: `docker run --rm -v $pwd/data:scratch cerr-octave:cudnn octave /ana/demo_runSegForPlanC.m`

To run oct2py-based segmentation demo: `docker run --rm -v $pwd/data:/scratch cerr-octave:cudnn python /ana/run_dlseg.py`

Run Octave CLI interactively from container: `docker run -it --rm -v $pwd/data:/scratch cerr-octave:cudnn octave`
