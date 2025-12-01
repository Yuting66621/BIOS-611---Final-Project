# Dockerfile
FROM --platform=linux/arm64 rocker/tidyverse:latest

# Install system dependencies for additional packages
RUN apt-get update && apt-get install -y \
    libfontconfig1-dev \
    libcairo2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*


# Install additional packages
RUN install2.r --error --skipinstalled \
    corrplot \
    naniar \
    GGally \
    factoextra \
    cluster \
    plotly \
    caret \
    glmnet \
    pROC \
    randomForest \
    reshape2
 
RUN R -e "pkgs <- c('tidyverse', 'corrplot', 'naniar', 'GGally', 'factoextra', 'caret', 'randomForest'); \
    missing <- pkgs[!pkgs %in% installed.packages()[,'Package']]; \
    if(length(missing) > 0) { \
        cat('Missing packages:', missing, '\n'); \
        quit(status=1); \
    } else { \
        cat('✓ All required packages installed!\n'); \
    }"
WORKDIR /home/rstudio