#/bin/bash                                                                                                                                          

mkdir -p /home/vpic/vpic.bin

cd /home/vpic/vpic.bin
cmake \
  -DUSE_CATALYST=ON \
  -DCMAKE_BUILD_TYPE=Release \
  /home/vpic/vpic
make -j16

export CPLUS_INCLUDE_PATH=/home/vpic/vpic/src/util/catalyst/
./bin/vpic ../vpic/sample/8preconnection.cxx
mkdir -p /home/vpic/vpicrun2
cd /home/vpic/vpicrun2
export LD_LIBRARY_PATH=/usr/local/paraview.bin/lib
echo "Sleeping 5 to wait for filehandle."
sleep 5
echo "Launching 8preconnection"
LD_LIBRARY_PATH=/usr/local/paraview.bin/lib mpirun --allow-run-as-root -np 8 /home/vpic/vpic.bin/8preconnection.Linux
