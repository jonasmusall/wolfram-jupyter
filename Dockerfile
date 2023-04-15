# syntax=docker/dockerfile:1

FROM wolframresearch/wolframengine:latest

ARG uname
ARG uid
ARG gname
ARG gid

USER root

# Set up running user.
RUN groupadd -g $gid $gname && useradd -m -g $gid -u $uid $uname

# Install jupyter and notebook interface.
# TODO: upgrade to jupyterlab
RUN pip3 install jupyter notebook

# https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#docker-cmd
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# Install WolframResearch/WolframLanguageForJupyter.
COPY ./Licensing/mathpass /usr/share/WolframEngine/Licensing/mathpass
WORKDIR /opt
RUN wget -q -O - https://github.com/WolframResearch/WolframLanguageForJupyter/archive/refs/tags/v0.9.3.tar.gz | tar -xz
# Use modified configure-jupyter script to globally install Kernel.
COPY ./configure-jupyter.wls /opt/WolframLanguageForJupyter-0.9.3/configure-jupyter.wls
RUN /opt/WolframLanguageForJupyter-0.9.3/configure-jupyter.wls add
WORKDIR /
# Remove mathpass again. Mount as volume when running image instead.
RUN rm /usr/share/WolframEngine/Licensing/mathpass

#USER wolframengine
# Create jupyter notebook directory.
RUN mkdir -p /mnt/jupyter && chmod a+rwx /mnt/jupyter

USER $uname

ENTRYPOINT ["/usr/bin/tini", "--"]
EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--notebook-dir='/mnt/jupyter'"]
