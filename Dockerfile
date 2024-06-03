FROM continuumio/miniconda3

WORKDIR /app

COPY . /app

# Configure conda to use conda-forge
RUN conda config --add channels conda-forge && \
    conda config --set channel_priority strict

# Install the environment from environment.yml
RUN conda env create -f environment.yml && conda clean -a -y

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["conda", "run", "-n", "myenv", "python", "main.py"]
