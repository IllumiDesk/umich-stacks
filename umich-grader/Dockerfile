FROM illumidesk/umich-notebook:latest

# add group id since its not included by repo2docker but we need it
# to run fix-permissions
ARG NB_UID=10001
ARG NB_GID=100

# add group id since its not included by repo2docker but we need it
# to run fix-permissions
ENV NB_USER=jovyan
ENV NB_UID="${NB_UID}"
ENV NB_GID="${NB_GID}"
ENV HOME="/home/${NB_USER}"

USER root

RUN jupyter nbextension enable --sys-prefix create_assignment/main \
 && jupyter nbextension enable --sys-prefix formgrader/main --section=tree \
 && jupyter serverextension enable --sys-prefix nbgrader.server_extensions.formgrader

# fix permissions as root
RUN fix-permissions /srv/julia \
 && fix-permissions "${HOME}" \
 && fix-permissions "${CONDA_DIR}"

# ensure we start user sessions with nb_user/nb_uid 
USER "${NB_USER}"

WORKDIR "${HOME}"
