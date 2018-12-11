# openvino docker with python 3.6
Creating OpenVINO docker image

This is slightli modified version from [this repo](https://github.com/mateoguzman/openvino-docker)

Assuming you already downloaded OpenVINO and unpacked the .tgz file 

Tested with OpenVINO R4

### Build docker
$ docker build -t openvino . 

### Run docker
$ docker run -ti openvino bash 
