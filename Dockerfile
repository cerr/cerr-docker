FROM python:3.9.4-buster
RUN apt-get update
RUN apt-get -y install curl wget nano libgraphicsmagick++1-dev libsuitesparse-dev libqrupdate1 libfftw3-3 libhdf5-100 libgl1 libglu1-mesa libgl2ps1.4 \
        libcurl4-gnutls-dev libarpack2 libopenblas-base git gnuplot
RUN pip3 install oct2py

RUN apt-get install curl
RUN LOCATION=$(curl -s https://api.github.com/repos/cerr/octave-colab/releases/latest \
| awk -F\" '/browser_download_url/ { print $4 }') && curl -L -o octavecolab.tar.gz $LOCATION
 
RUN unzip octavecolab.zip -d octavecolab && tar xzvf "octavecolab/octave-colab-6.2/octavecolab.tar.gz"

RUN export OCTAVE_EXECUTABLE=./octavecolab/bin/octave-cli && export PATH=./octavecolab/bin/:$PATH

RUN apt-get --yes install octave liboctave-dev

RUN wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/image-2.12.0.tar.gz && \
    wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/io-2.6.1.tar.gz  && \
    wget https://nchc.dl.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/statistics-1.4.2.tar.gz 

RUN octave --eval "pkg install io-2.6.1.tar.gz" && \
    octave --eval "pkg install image-2.12.0.tar.gz" && \
    octave --eval "pkg install statistics-1.4.2.tar.gz"

RUN mkdir /content && cd /content && git clone https://github.com/cerr/CERR.git && cd ./CERR && git checkout octave_dev && cd /

# Copy analysis/function scripts to /ana
RUN mkdir /ana
COPY radiomic_and_dosimetric_feature_extraction.m /ana/radiomic_and_dosimetric_feature_extraction.m
COPY run_cerr.py /ana/run_cerr.py

ENTRYPOINT [ "python3", "/ana/run_cerr.py" ]
