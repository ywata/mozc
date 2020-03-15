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

python2 build_mozc.py gyp --target_platform=Android --android_arch=arm64
if [ $? -ne 0 ]; then
    echo "build_mozc.py gyp failed" 2&>1
fi


cd $DIR/../src/android/app/src/main
if [ ! -e  "$DIR/../src/android/app/src/main" ]; then
    # TODO: This should be better handled by resource.gyp or similar.
    ln -s ../../../../out_android/Debug/gen/android/resources/res .
fi

cd $DIR/../src
python2 build_mozc.py build -c Debug android/android.gyp:adt_apk_dependencies

cd $DIR/../src/android
./gradlew assembleDebug
