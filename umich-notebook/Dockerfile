FROM jupyter/base-notebook:45bfe5a474fa AS base

FROM illumidesk/umich-base:latest

ARG NB_UID=1000
ARG NB_GID=100

# add group id since its not included by repo2docker but we need it
# to run fix-permissions
ENV NB_USER=jovyan
ENV NB_UID="${NB_UID}"
ENV NB_GID="${NB_GID}"
ENV HOME="/home/${NB_USER}"

USER root

# first config location checked by jupyter --paths
RUN mkdir -p /etc/jupyter

# copy files from base image
# start* includes: start-notebook.sh, start-singleuser.sh, and start.sh
COPY --from=base /usr/local/bin/start* /usr/local/bin/
COPY --from=base /usr/local/bin/fix-permissions /usr/local/bin/

# copy upstream config and rename it to base config. custom config loads base config
# with additional settings
COPY --from=base /etc/jupyter/jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config_base.py

# update permissions
RUN chmod a+rx /usr/local/bin/fix-permissions
RUN chmod +rx /usr/local/bin/start*

# start.sh has the option of running scripts as hooks
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html#startup-hooks
RUN mkdir -p /usr/local/bin/start-notebook.d \
 && mkdir -p /usr/local/bin/before-notebook.d

COPY enable_extensions.sh /usr/local/bin/before-notebook.d/
RUN chmod a+rx /usr/local/bin/before-notebook.d/enable_extensions.sh

# copy configs, we use our own to provide a base jhub config and an additional
# default config that loads/appends from the base config. this is usefule in case
# we need to add other images that default to other paths, etc.
RUN mkdir -p /etc/jupyter
COPY jupyter_notebook_config.py /etc/jupyter/
COPY global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

# make sure the right dirs are writable by the `users` group
RUN touch /etc/sudoers \
 && echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    chmod g+w /etc/passwd

# update permissions, since repo2docker uses the same id for user and group
RUN chown -Rf "${NB_UID}":"${NB_GID}" /srv/julia \
 && chown -Rf "${NB_UID}":"${NB_GID}" "${CONDA_DIR}" \
 && chown -Rf "${NB_UID}":"${NB_GID}" "${HOME}"

# fix permissions for jupyter/docker-stacks compatibility
RUN fix-permissions /srv/julia \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "${HOME}"

# create path required by start.sh
RUN mkdir -p /etc/sudoers.d/

# create symlink to jupyterhub-singleuser to handle run/spawn when setting user to root(0)
RUN ln -s "${CONDA_DIR}/envs/notebook/bin/jupyter" /usr/local/bin/ \
 && ln -s "${CONDA_DIR}/envs/notebook/bin/jupyterhub-singleuser" /usr/local/bin/

USER "${NB_UID}"

# install nbgrader and then disable all extensions by default
RUN jupyter nbextension install --symlink --sys-prefix --py nbgrader --overwrite \
 && jupyter nbextension disable --sys-prefix --py nbgrader \
 && jupyter serverextension disable --sys-prefix --py nbgrader

# everyone gets the nbgrader validate extension
RUN jupyter nbextension enable --sys-prefix validate_assignment/main --section=notebook \
 && jupyter serverextension enable --sys-prefix nbgrader.server_extensions.validate_assignment

WORKDIR "${HOME}"

EXPOSE 8888

# Configure containe startup, as the standard repo2docker-based
# image uses the repo2docker entrypoint. establishes consistency with
# jupyter/docker-stacks images
ENTRYPOINT ["tini", "-g", "--"]

# allows for local docker-run commands. will run start-singleuser if
# spawned with jupyterhub
CMD ["start-notebook.sh"]