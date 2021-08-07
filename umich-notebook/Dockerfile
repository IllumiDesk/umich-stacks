# Based mostly off of https://github.com/jupyter/docker-stacks/datascience-notebook image
ARG BASE_CONTAINER=jupyter/datascience-notebook:julia-1.6.1
FROM $BASE_CONTAINER

USER ${NB_UID}

# Install julia packages
COPY install.jl /tmp/install.jl
RUN julia /tmp/install.jl \
 && fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}" \
 && rm /tmp/install.jl

# copy configs, we use our own to provide a base jhub config and an additional
# default config that loads/appends from the base config. this is usefule in case
# we need to add other images that default to other paths, etc.
RUN mkdir -p /etc/jupyter
COPY --from=base /etc/jupyter/jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config_base.py
COPY jupyter_notebook_config.py /etc/jupyter/
COPY global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

# update permissions as root
USER root
RUN fix-permissions /etc/jupyter/ \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

WORKDIR "${HOME}"

USER "${NB_UID}"
