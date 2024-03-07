FROM python:3.11-slim AS base
RUN apt-get update -qq --fix-missing \
    && apt-get install -y --no-install-recommends ffmpeg python3-scipy \
    && rm -rf /var/lib/apt/lists/*

FROM base AS build
COPY requirements/dev.txt ./requirements/

RUN pip install --upgrade pip
# install dependencies to the local user directory (eg. /root/.local)
RUN pip install --user -r requirements/dev.txt

FROM base

WORKDIR /usr/src/app

# copy only the dependencies installation from the 1st stage image
COPY --from=build /root/.local /root/.local
COPY . /usr/src/app

ENV PATH=/root/.local/bin:$PATH

CMD ["bash"]
