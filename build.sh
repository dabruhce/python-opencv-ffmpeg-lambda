#!/bin/sh -x
export BUILD_DIR=$PWD

yum groupinstall -y "Development Tools" && yum install -y cmake bsdtar nasm
yum install -y python-devel

curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py
pip install numpy
NUMPY=/usr/local/lib64/python2.7/site-packages/numpy/core/include

set -x && mkdir -pv ~/tmp && cd ~/tmp \
  && curl https://ffmpeg.org/releases/ffmpeg-3.0.2.tar.bz2 | tar -jxf - && cd ffmpeg-* \
  && ./configure --enable-shared --disable-static --disable-programs --disable-doc --prefix=/var/task \
  && make install

set -x && mkdir -pv ~/tmp && cd ~/tmp \
  && curl -L https://github.com/Itseez/opencv/archive/3.1.0.zip | bsdtar -xf- && cd opencv-* \
  && mkdir build && cd build \
  && curl -L https://github.com/Itseez/opencv_contrib/archive/3.1.0.tar.gz | tar -zxf - && CONTRIB=$(ls -d opencv_contrib-*/modules) \
  && PKG_CONFIG_PATH=/var/task/lib/pkgconfig cmake -D OPENCV_EXTRA_MODULES_PATH=$CONTRIB -D PYTHON2_NUMPY_INCLUDE_DIRS=$NUMPY -D CMAKE_BUILD_TYPE=RELEASE -D BUILD_PYTHON_SUPPORT=ON -D CMAKE_INSTALL_PREFIX=/var/task ../ \
  && LD_LIBRARY_PATH=/var/task/lib make install

#PACKAGE
cd $BUILD_DIR
mkdir lambda lambda/lib
cd lambda
cd lib
cp /var/task/lib .
cd ..
cp /root/tmp/opencv-3.1.0/build/lib/cv2.so cv2.so
zip -r $BUILD_DIR/lambda.zip .
cd ..
zip -g lambda.zip lambda_function.py
