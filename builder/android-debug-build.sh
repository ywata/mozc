#!/bin/bash -e

#http://stackoverflow.com/a/246128/5209556
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo $DIR

cd $DIR/../src
python2 build_mozc.py gyp --target_platform=Android \
 && python2 build_mozc.py build \
        -c Debug \
        android/android.gyp:apk 

#cd $DIR/../src/project/android-studio
#./gradlew assembleDebug
