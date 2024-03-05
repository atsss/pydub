FROM python:3.11-slim AS base
RUN apt-get update -qq --fix-missing && apt-get install -y --no-install-recommends \
    ffmpeg \
    libopus-dev \
    python3-scipy \
    && rm -rf /var/lib/apt/lists/*

FROM base

COPY . /usr/src/app

WORKDIR /usr/src/app

CMD ["bash"]
