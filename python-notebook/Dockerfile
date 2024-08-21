# Based mostly off of:
# https://github.com/jupyter/docker-stacks/blob/main/images/julia-notebook
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/datascience-notebook
FROM ${BASE_CONTAINER}

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER ${NB_UID}

# Setup IJulia kernel & other packages
COPY --chown=${NB_UID}:${NB_GID} requirements.txt "${HOME}/requirements.txt"
WORKDIR "${HOME}"
RUN pip install -r requirements.txt


WORKDIR "${HOME}"

CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888"]
