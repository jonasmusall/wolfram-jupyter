#! /bin/sh

touch $(pwd)/Licensing/mathpass
docker run -it --rm -v $(pwd)/docker/activate.sh:/root/activate.sh -v $(pwd)/Licensing/mathpass:/root/mathpass -u root wolframresearch/wolframengine /root/activate.sh
