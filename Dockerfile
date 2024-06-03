FROM python:3.11-slim

WORKDIR /app

COPY . /app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "main.py"]
