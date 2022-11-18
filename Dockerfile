FROM --platform=linux/amd64 ubuntu:20.04

# Update and install required packages
RUN apt-get -y update && \
    apt-get install -y wget gnupg software-properties-common && \
    apt install -y python3-pip python3-dev ipython3 && \
    python3 -m pip install ipykernel && \
    python3 -m ipykernel install && \
    pip3 install pylint

RUN cd /tmp && \
    wget https://az764295.vo.msecnd.net/stable/6ab598523be7a800d7f3eb4d92d7ab9a66069390/code_1.39.2-1571154070_amd64.deb && \
    dpkg -i code_1.39.2-1571154070_amd64.deb && \
    rm -f code_1.39.2-1571154070_amd64.deb

ENTRYPOINT $*
