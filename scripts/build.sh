#! /bin/sh

docker build -t wolfram-jupyter --build-arg uname=$(id -un) --build-arg uid=$(id -u) --build-arg gname=$(id -gn) --build-arg gid=$(id -g) $(pwd)

cat > $(pwd)/scripts/run.sh << EOF
#! /bin/sh

if [ \$# != 1 ]; then
  echo 'Expected 1 argument: working directory for Jupyter' >&2
  return 1
fi
if [ ! -d "\$1" ]; then
  echo "\$1 is not a directory" >&2
  return 2
fi
docker run -it --rm -v $(pwd)/Licensing/mathpass:/home/$(id -un)/.WolframEngine/Licensing/mathpass -p 8888:8888 -v \$1:/mnt/jupyter wolfram-jupyter
EOF
chmod +x $(pwd)/scripts/run.sh
