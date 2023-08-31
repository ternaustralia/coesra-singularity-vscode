FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Update and install required packages
RUN apt-get -y update && \
    apt-get install -y wget gnupg software-properties-common libnotify4 python3-tk && \
    apt install -y python3-pip python3-dev ipython3
#    python3 -m pip install ipykernel && \
#    python3 -m ipykernel install

RUN pip3 install --upgrade pip

RUN apt update
RUN apt-get install -y clinfo

# Copy a script that we will use to correct permissions after running certain commands
#COPY fix-permissions.sh /usr/local/bin/fix-permissions
#RUN chmod a+rx /usr/local/bin/fix-permissions

ENV CONDA_DIR=/opt/conda
ENV PATH="${CONDA_DIR}/bin:${PATH}"

# Install mamba forge
RUN cd /tmp
RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
RUN bash Miniforge3.sh -b -p "${CONDA_DIR}"
RUN conda clean --tarballs --index-cache --packages --yes && \
    find ${CONDA_DIR} -follow -type f -name '*.a' -delete && \
    find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete && \
    conda clean --force-pkgs-dirs --all --yes

# Install python packages
RUN mamba install --yes pylint numpy scipy pandas matplotlib beautifulsoup4 scrapy eli5 pipenv scikit-learn==1.2.0
RUN pip3 install bob structure

# setuid bit on conda directories
#RUN chmod -R +6000 "${CONDA_DIR}"

# Install vscode
RUN cd /tmp && \
    wget https://az764295.vo.msecnd.net/stable/6ab598523be7a800d7f3eb4d92d7ab9a66069390/code_1.39.2-1571154070_amd64.deb && \
    dpkg -i code_1.39.2-1571154070_amd64.deb && \
    rm -f code_1.39.2-1571154070_amd64.deb

ENTRYPOINT $*