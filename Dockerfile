# syntax=docker/dockerfile:1

FROM wolframresearch/wolframengine:latest

ARG uname
ARG uid
ARG gname
ARG gid

USER root

# Set up running user.
RUN groupadd -g $gid $gname && useradd -m -g $gid -u $uid $uname

RUN apt-get update
RUN apt-get upgrade -y

# Install jupyter and notebook interface.
# TODO: upgrade to jupyterlab
RUN pip3 install --no-cache-dir jupyterlab

# https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#docker-cmd
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# Install WolframResearch/WolframLanguageForJupyter.
ENV WLFJ_VERSION 0.9.3
COPY ./Licensing/mathpass /root/.WolframEngine/Licensing/mathpass
WORKDIR /opt
RUN wget -q -O - https://github.com/WolframResearch/WolframLanguageForJupyter/archive/refs/tags/v${WLFJ_VERSION}.tar.gz | tar -xz
# Use modified configure-jupyter script to globally install Kernel.
COPY ./configure-jupyter.wls /opt/WolframLanguageForJupyter-${WLFJ_VERSION}/configure-jupyter.wls
RUN /opt/WolframLanguageForJupyter-${WLFJ_VERSION}/configure-jupyter.wls add
WORKDIR /
# Remove mathpass again. Mount as volume when running image instead.
RUN rm /root/.WolframEngine/Licensing/mathpass

#USER wolframengine
# Create jupyter notebook directory.
RUN mkdir -p /mnt/jupyter && chmod a+rwx /mnt/jupyter

USER $uname

ENTRYPOINT ["/usr/bin/tini", "--"]
EXPOSE 8888
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--notebook-dir='/mnt/jupyter'"]
