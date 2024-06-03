FROM python:3.11-slim

WORKDIR /app

COPY . /app

# Install required dependencies and Miniconda
RUN apt-get update && apt-get install -y wget bzip2 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

# Set up the environment path for conda
ENV PATH /opt/conda/bin:$PATH

# Install dependencies from environment.yml
RUN conda config --set always_yes yes --set changeps1 no && \
    conda update -q conda && \
    conda info -a && \
    conda env create -f environment.yml && \
    conda clean -a -y

# Activate the environment and set up shell
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["conda", "run", "-n", "myenv", "python", "main.py"]
