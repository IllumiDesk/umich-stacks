# Based mostly off of https://github.com/jupyter/docker-stacks/datascience-notebook image
ARG BASE_IMAGE=jupyter/datascience-notebook:julia-1.6.1
FROM $BASE_IMAGE

ENV NB_UID=1000
ENV NB_GID=100

USER "${NB_UID}"

# Install julia packages
COPY install.jl /tmp/install.jl
RUN julia /tmp/install.jl \
 && fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

# copy configs, we use our own to provide a base jhub config and an additional
# default config that loads/appends from the base config. this is usefule in case
# we need to add other images that default to other paths, etc.
RUN mkdir -p /etc/jupyter
RUN cp /etc/jupyter/jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config_base.py
COPY jupyter_notebook_config.py /etc/jupyter/
COPY global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt

# install nbgrader and then disable all extensions by default
RUN jupyter nbextension install --symlink --sys-prefix --py nbgrader --overwrite \
 && jupyter nbextension disable --sys-prefix --py nbgrader \
 && jupyter serverextension disable --sys-prefix --py nbgrader

# everyone gets the nbgrader validate extension
RUN jupyter nbextension enable --sys-prefix validate_assignment/main --section=notebook \
 && jupyter serverextension enable --sys-prefix nbgrader.server_extensions.validate_assignment

# everyone gets the course list and assignment list extensions
RUN jupyter serverextension enable --sys-prefix nbgrader.server_extensions.assignment_list \
 && jupyter serverextension enable --sys-prefix nbgrader.server_extensions.course_list \
 && jupyter nbextension enable --sys-prefix course_list/main --section=tree \
 && jupyter nbextension enable --sys-prefix assignment_list/main --section=tree

# update permissions as root
USER root
RUN fix-permissions /etc/jupyter/ \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

USER "${NB_UID}"

WORKDIR "${HOME}"