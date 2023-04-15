#! /bin/sh

if [ $# != 1 ]; then
  echo 'Expected 1 argument: working directory for Jupyter' >&2
  return 1
fi
if [ ! -d "$1" ]; then
  echo "\"$1\" is not a directory" >&2
  return 2
fi
#docker run -it --rm -v /home/jonas/projects/docker/wolfram-jupyter/Licensing/mathpass:/usr/share/WolframEngine/Licensing/mathpass -p 8888:8888 -v $1:/mnt/jupyter wolfram-jupyter
