# xattr -cr .
# make -C source/py default

rm -rf ./build ./externals

pushd .

mkdir build
cd build

# cmake -G Xcode ..
cmake -G Xcode -DPYTHON_EXECUTABLE=$(python3 -c "import sys; print(sys.executable)") ..
cmake --build .

popd

