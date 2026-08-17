# Reproducible environment for running the insecticide resistance demo scripts
# from Hancock et al., (2020)
#
# Build:
#   docker build -t insecticide-resistance-env .
#
# Run, mounting this repo folder into the container:
#   docker run -it -v $(pwd):/repo/ insecticide-resistance-env bash
#

FROM --platform=linux/amd64 rocker/r-ver:4.6.1

# System libraries needed for building packages and geospatial work
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgsl-dev \
    libopenblas-dev \
    libudunits2-dev \
    libproj-dev \
    libgeos-dev \
    libgdal-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install remotes for version pinning where needed
RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org')"

# Core packages - use compatible modern versions
RUN R -e "install.packages(c('data.table','zoo','caret','mboost','randomForest'), repos='https://cloud.r-project.org')"

# LaplacesDemon (needed by several scripts)
RUN R -e "remotes::install_version('LaplacesDemon', version = '16.1.0', repos = 'https://cloud.r-project.org')"

# R-INLA with current fmesher support (no version pinning)
RUN R -e "install.packages('INLA', repos = c(getOption('repos'), INLA = 'https://inla.r-inla-download.org/R/stable'), dep = TRUE)"

WORKDIR /repo
