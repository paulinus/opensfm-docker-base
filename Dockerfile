FROM ubuntu:16.04


# Install apt-getable dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        git \
        libatlas-base-dev \
        libboost-python-dev \
        libeigen3-dev \
        libgoogle-glog-dev \
        libopencv-dev \
        libsuitesparse-dev \
        python-dev \
        python-numpy \
        python-opencv \
        python-pip \
        python-pyexiv2 \
        python-pyproj \
        python-scipy \
        python-yaml \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install Ceres from source
RUN \
    mkdir -p /source && cd /source && \
    wget http://ceres-solver.org/ceres-solver-1.14.0.tar.gz && \
    tar xvzf ceres-solver-1.14.0.tar.gz && \
    cd /source/ceres-solver-1.14.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make install && \
    cd / && \
    rm -rf /source/ceres-solver-1.14.0 && \
    rm -f /source/ceres-solver-1.14.0.tar.gz


# Install opengv from source
RUN \
    mkdir -p /source && cd /source && \
    git clone https://github.com/paulinus/opengv.git && \
    cd /source/opengv && \
    mkdir -p build && cd build && \
    cmake .. -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON && \
    make install && \
    cd / && \
    rm -rf /source/opengv


# Install python requirements
RUN \
    pip install exifread==2.1.2 \
                gpxpy==1.1.2 \
                networkx==1.11 \
                numpy \
                pyproj==1.9.5.1 \
                pytest==3.0.7 \
                python-dateutil==2.6.0 \
                PyYAML==3.12 \
                scipy \
                xmltodict==0.10.2 \
                cloudpickle==0.4.0 \
                loky==1.2.1
