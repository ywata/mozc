#!/bin/bash -e

#http://stackoverflow.com/a/246128/5209556
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $DIR
sudo buildah bud \
    --layers \
    --build-arg uid=$(id -u) \
    --build-arg gid=$(id -g) \
    --build-arg lang=$LANG \
    --volume=$DIR/../../home:/home/builder \
    --volume=$DIR/../..:/home/builder/workshop \
    --tag $USER/kurage_ubuntu18.04 .
# env DOCKER_BUILDKIT=1 \
# sudo docker build --rm \
#     --build-arg uid=$(id -u) \
#     --build-arg gid=$(id -g) \
#     --build-arg lang=$LANG \
#     -t $USER/kurage_ubuntu18.04 .
# env DOCKER_BUILDKIT=1 \
# sudo docker-compose build \
#     --build-arg uid=$(id -u) \
#     --build-arg gid=$(id -g) \
#     --build-arg lang=$LANG
