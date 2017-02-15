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
             -DBUILD_opencv_aruco=OFF \
             -DBUILD_opencv_bgsegm=OFF \
             -DBUILD_opencv_bioinspired=OFF \
             -DBUILD_opencv_calib3d=OFF \
             -DBUILD_opencv_ccalib=OFF \
             -DBUILD_opencv_cnn_3dobj=OFF \
             -DBUILD_opencv_cudaarithm=OFF \
             -DBUILD_opencv_cudabgsegm=OFF \
             -DBUILD_opencv_cudacodec=OFF \
             -DBUILD_opencv_cudafilters=OFF \
             -DBUILD_opencv_cudalegacy=OFF \
             -DBUILD_opencv_cudaobjdetect=OFF \
             -DBUILD_opencv_cudaoptflow=OFF \
             -DBUILD_opencv_cudastereo=OFF \
             -DBUILD_opencv_cudawarping=OFF \
             -DBUILD_opencv_cudev=OFF \
             -DBUILD_opencv_cvv=OFF \
             -DBUILD_opencv_datasets=OFF \
             -DBUILD_opencv_dnn=OFF \
             -DBUILD_opencv_dnn_modern=OFF \
             -DBUILD_opencv_dnns_easily_fooled=OFF \
             -DBUILD_opencv_dpm=OFF \
             -DBUILD_opencv_face=OFF \
             -DBUILD_opencv_freetype=OFF \
             -DBUILD_opencv_fuzzy=OFF \
             -DBUILD_opencv_hdf=OFF \
             -DBUILD_opencv_java=OFF \
             -DBUILD_opencv_line_descriptor=OFF \
             -DBUILD_opencv_matlab=OFF \
             -DBUILD_opencv_optflow=OFF \
             -DBUILD_opencv_phase_unwrapping=OFF \
             -DBUILD_opencv_plot=OFF \
             -DBUILD_opencv_reg=OFF \
             -DBUILD_opencv_rgbd=OFF \
             -DBUILD_opencv_saliency=OFF \
             -DBUILD_opencv_sfm=OFF \
             -DBUILD_opencv_shape=OFF \
             -DBUILD_opencv_stereo=OFF \
             -DBUILD_opencv_stitching=OFF \
             -DBUILD_opencv_structured_light=OFF \
             -DBUILD_opencv_superres=OFF \
             -DBUILD_opencv_surface_matching=OFF \
             -DBUILD_opencv_text=OFF \
             -DBUILD_opencv_tracking=OFF \
             -DBUILD_opencv_ts=OFF \
             -DBUILD_opencv_videoio=OFF \
             -DBUILD_opencv_videostab=OFF \
             -DBUILD_opencv_viz=OFF \
             -DBUILD_opencv_world=OFF \
             -DBUILD_opencv_xfeatures2d=ON \
             -DBUILD_opencv_ximgproc=OFF \
             -DBUILD_opencv_xobjdetect=OFF \
             -DBUILD_opencv_xphoto=OFF \
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
