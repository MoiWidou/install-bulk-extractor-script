cat << 'EOF' > install_bulk_extractor.sh
#!/bin/bash
set -e

echo ">>> Installing build tools..."
sudo yum groupinstall "Development Tools" -y

echo ">>> Installing required libraries..."
sudo yum install -y git wget unzip autoconf automake libtool \
  openssl-devel zlib-devel bzip2-devel

echo ">>> Downloading libewf..."
cd ~
wget https://github.com/libyal/libewf/archive/refs/tags/libewf-experimental-20231119.tar.gz -O libewf-20231119.tar.gz
tar -xvf libewf-20231119.tar.gz
cd libewf-libewf-experimental-20231119

echo ">>> Building libewf..."
./configure
make
sudo make install
sudo ldconfig

echo ">>> Downloading bulk_extractor..."
cd ~
wget https://github.com/simsong/bulk_extractor/archive/refs/tags/v2.0.0.tar.gz
tar -xvf v2.0.0.tar.gz
cd bulk_extractor-2.0.0

echo ">>> Building bulk_extractor..."
./bootstrap.sh
./configure
make
sudo make install
sudo ldconfig

echo "================================================="
echo " bulk_extractor successfully installed!"
echo " Run it using: bulk_extractor -h"
echo "================================================="
EOF

chmod +x install_bulk_extractor.sh
bash install_bulk_extractor.sh
