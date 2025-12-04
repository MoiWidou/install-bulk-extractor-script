cat << 'EOF' > install_bulk_extractor.sh
#!/bin/bash
set -e
SCRIPTDIR="$(pwd)"
echo ">>> Cleaning up any previous build attempts..."
rm -rf ~/libewf-* ~/bulk_extractor-* ~/libewf.tar.gz ~/bulk_extractor.tar.gz

echo ">>> Installing build tools & dependencies..."
sudo yum groupinstall "Development Tools" -y
sudo yum install -y git wget unzip autoconf automake libtool \
  openssl-devel zlib-devel bzip2-devel pkgconfig

echo ">>> Downloading libewf (latest release)..."
cd ~
# Use latest known release tag of libewf
LIBEWF_VER="20240506"
wget -O libewf-${LIBEWF_VER}.tar.gz \
  https://github.com/libyal/libewf/archive/refs/tags/libewf-experimental-${LIBEWF_VER}.tar.gz

echo ">>> Extracting libewf..."
tar -xvf libewf-${LIBEWF_VER}.tar.gz
cd libewf-libewf-experimental-${LIBEWF_VER}

echo ">>> Building & installing libewf..."
./configure
make
sudo make install
sudo ldconfig

echo ">>> Downloading bulk_extractor 2.0.0..."
cd ~
wget -O bulk_extractor-2.0.0.tar.gz \
  https://downloads.digitalcorpora.org/downloads/bulk_extractor/bulk_extractor-2.0.0.tar.gz

echo ">>> Extracting bulk_extractor..."
tar -xvf bulk_extractor-2.0.0.tar.gz
cd bulk_extractor-2.0.0

echo ">>> Building & installing bulk_extractor..."
./bootstrap.sh
./configure
make
sudo make install
sudo ldconfig

echo "================================================="
echo " bulk_extractor installed successfully!"
echo " Version:"
bulk_extractor -V
echo "You can run scans like: bulk_extractor -R -o ~/be_output /path/to/scan"
echo "================================================="
EOF

chmod +x install_bulk_extractor.sh
./install_bulk_extractor.sh
