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
        python-pip \
        python-pyexiv2 \
        python-pyproj \
        python-scipy \
        python-yaml \
        vim \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install OpenCV 3
RUN \
    mkdir -p /source && cd /source && \
    wget --quiet https://github.com/opencv/opencv/archive/3.2.0.tar.gz -O opencv-3.2.0.tar.gz && \
    tar xzf opencv-3.2.0.tar.gz && \
    wget --quiet https://github.com/opencv/opencv_contrib/archive/3.2.0.tar.gz -O opencv_contrib-3.2.0.tar.gz  && \
    tar xzf opencv_contrib-3.2.0.tar.gz && \
    cd /source/opencv-3.2.0 && \
    mkdir -p build && cd build && \
    cmake .. -DOPENMP=OFF \
             -DBUILD_DOCS=OFF \
             -DBUILD_EXAMPLES=OFF \
             -DBUILD_OPENCV_APPS=OFF \
             -DBUILD_PERF_TEST=OFF \
             -DBUILD_TESTS=OFF \
             -DOPENCV_EXTRA_MODULES_PATH=/source/opencv_contrib-3.2.0/modules \
             && \
    make -j$(nproc) install && \
    cd / && \
    rm -rf /source/opencv-3.2.0 && \
    rm -f /source/opencv-3.2.0.tar.gz \
    rm -rf /source/opencv_contrib-3.2.0 && \
    rm -f /source/opencv_contrib-3.2.0.tar.gz


# Install Ceres from source
RUN \
    mkdir -p /source && cd /source && \
    wget --quiet http://ceres-solver.org/ceres-solver-1.10.0.tar.gz && \
    tar xzf ceres-solver-1.10.0.tar.gz && \
    cd /source/ceres-solver-1.10.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make -j$(nproc) install && \
    cd / && \
    rm -rf /source/ceres-solver-1.10.0 && \
    rm -f /source/ceres-solver-1.10.0.tar.gz


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
