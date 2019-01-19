FROM ubuntu:18.04


# Install apt-getable dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        git \
        libatlas-base-dev \
        libeigen3-dev \
        libgoogle-glog-dev \
        libopencv-dev \
        libsuitesparse-dev \
        python3-dev \
        python3-numpy \
        python3-opencv \
        python3-pip \
        python3-pyproj \
        python3-scipy \
        python3-yaml \
        curl \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# ceres
RUN \
    mkdir -p /source && cd /source && \
    curl -L http://ceres-solver.org/ceres-solver-1.14.0.tar.gz | tar xz && \
    cd /source/ceres-solver-1.14.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make -j4 install && \
    cd / && rm -rf /source/ceres-solver-1.14.0


# opengv
RUN \
    mkdir -p /source && cd /source && \
    git clone https://github.com/paulinus/opengv.git && \
    cd /source/opengv && \
    git submodule update --init --recursive && \
    mkdir -p build && cd build && \
    cmake .. -DBUILD_TESTS=OFF \
             -DBUILD_PYTHON=ON \
             -DPYBIND11_PYTHON_VERSION=3.6 \
             -DPYTHON_INSTALL_DIR=/usr/local/lib/python3.6/dist-packages/ \
             && \
    make install && \
    cd / && rm -rf /source/opengv


# Install python requirements
RUN \
    pip3 install exifread==2.1.2 \
                 gpxpy==1.1.2 \
                 networkx==1.11 \
                 numpy \
                 pyproj==1.9.5.1 \
                 pytest==3.0.7 \
                 python-dateutil==2.6.0 \
                 PyYAML==3.12 \
                 scipy \
                 xmltodict==0.10.2 \
                 loky \
                 repoze.lru
