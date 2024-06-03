FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y wget bzip2 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN /opt/conda/bin/conda init && \
    /opt/conda/bin/conda env create -f environment.yml && \
    /opt/conda/bin/conda clean -a -y

EXPOSE 5000

CMD ["python", "main.py"]
