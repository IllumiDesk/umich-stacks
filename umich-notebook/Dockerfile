# Based mostly off of https://github.com/jupyter/docker-stacks/datascience-notebook image
ARG TAG=julia-1.9.0
ARG BASE_IMAGE=jupyter/datascience-notebook
FROM $BASE_IMAGE:$TAG

ENV NB_UID=1000
ENV NB_GID=100

USER "${NB_UID}"

# Install julia packages
RUN curl https://s3.us-west-2.amazonaws.com/configs.illumidesk.com/docker/install.jl --output /tmp/install.jl
RUN julia /tmp/install.jl
RUN fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

RUN pip install jupyter_kernel_gateway psycopg2-binary

# update permissions as root
USER root
RUN fix-permissions /etc/jupyter/ \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "${JULIA_PKGDIR}" \
 && fix-permissions "${HOME}"

RUN mv "${CONDA_DIR}/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/julia/"

USER "${NB_UID}"

WORKDIR "${HOME}"

CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888"]