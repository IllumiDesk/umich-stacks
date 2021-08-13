ARG TAG=julia-1.6.1
ARG BASE_IMAGE=illumidesk/umich-notebook

FROM $BASE_IMAGE:$TAG
# update with grader user id and group id
ENV NB_UID=10001
ENV NB_GID=100

# enable nbgrader's create assignment and formgrader extensions
RUN jupyter nbextension enable --sys-prefix create_assignment/main \
 && jupyter nbextension enable --sys-prefix formgrader/main --section=tree \
 && jupyter serverextension enable --sys-prefix nbgrader.server_extensions.formgrader

# disable the assignment extension, since graders don't need it
RUN jupyter serverextension enable --sys-prefix nbgrader.server_extensions.assignment_list \
 && jupyter nbextension enable --sys-prefix assignment_list/main --section=tree

# fix permissions as root
USER root
RUN fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}" \
 && fix-permissions "${CONDA_DIR}"

# ensure we start user sessions with nb_user/nb_uid 
USER "${NB_USER}"

WORKDIR "${HOME}"
