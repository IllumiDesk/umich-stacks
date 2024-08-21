# Based mostly off of:
# https://github.com/jupyter/docker-stacks/blob/main/images/julia-notebook
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/julia-notebook
FROM ${BASE_CONTAINER}

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER ${NB_UID}

# Setup IJulia kernel & other packages
COPY --chown=${NB_UID}:${NB_GID} setup-scripts/*.* /opt/setup-scripts/.
RUN chmod +rx /opt/setup-scripts/install-julia-packages.bash \
    && /opt/setup-scripts/install-julia-packages.bash

RUN pip install jupyter_kernel_gateway psycopg2-binary

WORKDIR "${HOME}"

CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888"]
