FROM --platform=linux/amd64 python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Qiskit
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "qiskit==0.43.2" qiskit[visualization] jupyter

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

