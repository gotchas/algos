#!/usr/bin/env sh

THIS_DIR=$(realpath $(dirname $0))

/usr/bin/cmake --no-warn-unused-cli -DCMAKE_PROJECT_INCLUDE_BEFORE:STRING=$THIS_DIR/SetupHunter.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_C_COMPILER:FILEPATH=/bin/clang-10 -DCMAKE_CXX_COMPILER:FILEPATH=/bin/clang++-10 -H$THIS_DIR -B$THIS_DIR/build -G Ninja

/usr/bin/cmake --build $THIS_DIR/build --config Debug --target all -- -j 10
cd $THIS_DIR/build
# the following option does notwork with target test:  --build $THIS_DIR/build
/usr/bin/ctest --build $THIS_DIR/build --config Debug --target test --output-on-failure -- -j 10
cd ..