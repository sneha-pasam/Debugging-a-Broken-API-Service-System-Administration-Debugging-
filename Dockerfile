FROM python:3.12-slim
ENV DEBIAN_FRONTEND=noninteractive

# Install OS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux asciinema curl gcc libc-dev make git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy app code
COPY app /app/app
COPY start.sh /app/start.sh
COPY requirements.txt /app/requirements.txt

# Install Python requirements INSIDE the image (this is the missing step)
RUN python -m pip install --no-cache-dir -r /app/requirements.txt

RUN chmod +x /app/start.sh

EXPOSE 5000
ENTRYPOINT ["/app/start.sh"]
