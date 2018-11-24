FROM quay.io/pypa/manylinux1_x86_64


# Install yumable dependencies
RUN yum install -y \
        git \
        atlas-devel \
        lapack-devel


# cmake
RUN \
    mkdir -p /source && cd /source && \
    curl -L https://cmake.org/files/v3.12/cmake-3.12.4.tar.gz | tar xz && \
    cd /source/cmake-3.12.4 && \
    ./bootstrap && make -j4 && make install && \
    cd / && rm -rf /source/cmake-3.12.4


# glog
RUN \
    mkdir -p /source && cd /source && \
    curl -L https://github.com/google/glog/archive/v0.3.5.tar.gz | tar xz && \
    cd /source/glog-0.3.5 && \
    ./configure && \
    make install && \
    cd / && rm -rf /source/glog-0.3.5


# gflags
RUN \
    mkdir -p /source && cd /source && \
    curl -L https://github.com/gflags/gflags/archive/v2.2.2.tar.gz | tar xz && \
    cd /source/gflags-2.2.2 && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_CXX_FLAGS=-fPIC && \
    make install && \
    cd / && rm -rf /source/gflags-2.2.2


# eigen3
RUN \
    mkdir -p /source && cd /source && \
    curl -L http://bitbucket.org/eigen/eigen/get/3.3.5.tar.gz | tar xz && \
    cd /source/eigen-eigen-* && \
    mkdir build && cd build && \
    cmake .. && \
    make install && \
    cd / && rm -rf /source/eigen-eigen-*


# ceres
RUN \
    mkdir -p /source && cd /source && \
    curl -L http://ceres-solver.org/ceres-solver-1.14.0.tar.gz | tar xz && \
    cd /source/ceres-solver-1.14.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make -j4 install && \
    cd / && rm -rf /source/ceres-solver-1.14.0


# opencv
RUN \
    mkdir -p /source && cd /source && \
    curl -L https://github.com/opencv/opencv/archive/3.4.4.tar.gz | tar xz && \
    cd /source/opencv-3.4.4 && \
    mkdir -p build && cd build && \
    cmake .. -DBUILD_LIST=core,imgproc,imgcodecs,calib3d && \
    make -j4 install && \
    cd / && rm -rf /source/opencv-3.4.4
