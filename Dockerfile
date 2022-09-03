FROM ubuntu:22.04

RUN apt -y update && apt install -y sudo wget vim curl gawk make gcc
RUN sudo apt install bzip2

RUN wget https://repo.continuum.io/archive/Anaconda3-2022.05-Linux-x86_64.sh && \
    sh Anaconda3-2022.05-Linux-x86_64.sh -b  && \
    rm -f Anaconda3-2022.05-Linux-x86_64.sh && \
    sudo curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -  && \
    sudo apt install -y nodejs

ENV PATH $PATH:/root/anaconda3/bin

RUN python -m pip install --upgrade pip
RUN python -m pip install pandas_datareader
RUN python -m pip install mplfinance
RUN python -m pip install japanize-matplotlib

RUN wget --quiet http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz -O ta-lib-0.4.0-src.tar.gz && \
    tar xvf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib/ && \
    ./configure --prefix=/usr && \
    make && \
    sudo make install && \
    cd .. && \
    pip install TA-Lib && \
    rm -R ta-lib ta-lib-0.4.0-src.tar.gz

RUN mkdir /workspace

CMD ["jupyter-lab", "--ip=0.0.0.0","--port=8888" ,"--no-browser", "--allow-root", "--LabApp.token=''"]
