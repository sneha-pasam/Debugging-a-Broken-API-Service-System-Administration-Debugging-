FROM python:3.12-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux asciinema curl gcc libc-dev make git && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
# Copy application code only (solution.sh and tests are excluded by .dockerignore)
COPY app /app/app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
EXPOSE 5000
ENTRYPOINT ["/app/start.sh"]
