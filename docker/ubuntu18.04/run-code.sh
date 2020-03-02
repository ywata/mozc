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

xhost local:root && \
pkexec docker run \
    -i \
    -u $(id -u):$(id -g) \
    --mount type=bind,source=/dev/bus/usb,target=/dev/bus/usb \
    --mount type=bind,source=/dev/kvm,target=/dev/kvm \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    --mount type=bind,source=$DIR/../../home,target=/home/builder \
    --mount type=bind,source=$DIR/../..,target=/home/builder/workshop \
    --mount type=bind,source=$DIR/../../key,target=/home/builder/workshop/key \
    -e DISPLAY=$DISPLAY \
    -e LANG=$LANG \
    -e LANGUAGE=$LANGUAGE \
    -e LC_ALL=$LC_ALL \
    -e XMODIFIERS=$XMODIFIERS \
    -e GTK_IM_MODULE=$GTK_IM_MODULE \
    -e QT_IM_MODULE=$QT_IM_MODULE \
    -e XIMPROGRAM=$XIMPROGRAM \
    --device=/dev/dri:/dev/dri \
    --device=/dev/snd:/dev/snd \
    --device=/dev/input:/dev/input \
    $USER/kurage_ubuntu18.04 \
    code --wait /home/builder/workshop
