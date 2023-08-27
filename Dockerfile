FROM rocker/rstudio:4.3.1

LABEL source="https://github.com/davetang/learning_docker/blob/main/rstudio/Dockerfile"

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		libhdf5-dev \
		libcurl4-gnutls-dev \
		libssl-dev \
		libxml2-dev \
		libpng-dev \
		libxt-dev \
		zlib1g-dev \
		libbz2-dev \
		liblzma-dev \
		libglpk40 \
		libgit2-dev \
		patch \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=rstudio:rstudio ./.Rprofile /home/rstudio/


RUN Rscript -e "install.packages(c('rmarkdown', 'tidyverse'));"

# the rstudio/ path is set for building with GitHub Actions
# COPY --chown=rstudio:rstudio rstudio/rstudio-prefs.json /home/rstudio/.config/rstudio

RUN mkdir /packages

ENV R_LIBS_USER=/packages

WORKDIR /home/rstudio