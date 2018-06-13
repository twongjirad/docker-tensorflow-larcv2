FROM tensorflow/tensorflow:1.8.0-gpu

MAINTAINER taritree.wongjirad@tufts.edu

# install ROOT
# RUN 
RUN apt-get update && apt-get install -y binutils \
	    	      	cmake \
			build-essential \
			libfftw3-dev \
			gcc \
			g++ \
			gfortran \
			git \
			libgsl0-dev \
			libjpeg-dev \
			libpng-dev \
			libx11-dev \
			libxext-dev \
			libxft-dev \
			libxml2-dev \
			libxpm-dev \
			python \
			ipython-notebook \
			python-dev \
			libssl-dev \
			libxml2-dev \
			tar \
			wget && \
    cd /tmp/ && \
    wget https://root.cern.ch/download/root_v6.12.04.source.tar.gz && tar -zxvf root_v6.12.04.source.tar.gz -C /tmp/ && \
    mkdir -p /tmp/build && cd /tmp/build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DGNUINSTALL=ON -DBUILTIN_XROOTD=ON /tmp/root-6.12.04 && \
    cmake --build . --target install -- -j4 && \
    rm /tmp/root_v6.12.04.source.tar.gz && rm -r /tmp/build && rm -r /tmp/root-6.12.04 && \
    apt-get autoremove -y && apt-get clean -y

# install larlite and larcv2(Tufts fork)
RUN bash -c "cd /usr/local \
    && git clone https://github.com/larlight/larlite larlite \
    && git clone https://github.com/nutufts/larcv2 larcv \
    && source /usr/local/bin/thisroot.sh \
    && cd /usr/local/larlite \
    && source /usr/local/larlite/config/setup.sh \
    && make \
    && cd /usr/local/larcv \
    && git checkout tufts_ub \
    && source configure.sh \
    && make"
