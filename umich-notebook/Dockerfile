# Based mostly off of https://github.com/jupyter/docker-stacks/datascience-notebook image
ARG TAG=julia-1.9.3
ARG BASE_IMAGE=jupyter/datascience-notebook
FROM $BASE_IMAGE:$TAG

ENV NB_UID=1000
ENV NB_GID=100

USER "${NB_UID}"

# Install julia packages
COPY --chown="${NB_UID}":"${NB_GID}" setup-scripts/install-julia-packages.bash /opt/setup-scripts/install-julia-packages.bash
RUN chmod +rx /opt/setup-scripts/install-julia-packages.bash
RUN fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

RUN pip install jupyter_kernel_gateway psycopg2-binary

# update permissions as root
USER root
# Julia dependencies
# install Julia packages in /opt/julia instead of ${HOME}
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia

# Setup Julia
RUN /opt/setup-scripts/install-julia-packages.bash

USER ${NB_UID}

# Setup IJulia kernel & other packages
RUN /opt/setup-scripts/setup-julia-packages.bash

WORKDIR "${HOME}"

CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888"]