# python-opencv-ffmpeg-lambda

Lambda function with python, Opencv, & ffmpeg.

````text
testing:
docker run -it -v $PWD:/var/task lambci/lambda:build bash

e.g. (windows)
docker run -it -v /C/Projects/python-opencv-ffmpeg-lambda/:/var/task lambci/lambda:build bash
./build.sh
copy .mpg into /C/Projects/python-opencv-ffmpeg-lambda
export PATH=$PATH:/var/task/lib
python lambda_function.py
````

````text
validate:
running python lambda_function.py

display:
version
true
It Works

ls -lrta /tmp

list image_0.jpeg with a size

````
