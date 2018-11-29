FROM ubuntu:16.04 AS build-env

WORKDIR /app
COPY l_openvino_toolkit_p_2018.4.420 /app/l_openvino_toolkit_p_2018.4.420

ARG INSTALL_DIR=/opt/intel/computer_vision_sdk

RUN apt-get update && apt-get -y upgrade && apt-get autoremove
RUN apt-get install -y --no-install-recommends \
    sudo \
    build-essential \
    cpio \
    curl \
    lsb-release \
    pciutils \
    software-properties-common 

RUN sudo add-apt-repository ppa:jonathonf/python-3.6 \
    apt-get update 

RUN apt-get install -y python3.6 python3.6-dev \
    curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3.6 \
    pip install numpy

# installing OpenVINO dependencies
RUN cd /app/l_openvino_toolkit* && \
    ./install_cv_sdk_dependencies.sh

## installing OpenVINO itself
RUN cd /app/l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh --silent silent.cfg

FROM ubuntu:16.04
COPY --from=build-env /opt/intel /opt/intel
WORKDIR /workdir

RUN apt-get update && apt-get -y upgrade && apt-get autoremove
RUN apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    curl \
    sudo 
RUN sudo add-apt-repository ppa:jonathonf/python-3.6 \
    apt-get update 

RUN apt-get install -y python3.6 python3.6-dev \
    curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3.6 \
    pip install numpy

CMD ["/bin/bash"]
