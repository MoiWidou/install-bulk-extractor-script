cat << 'EOF' > install_bulk_extractor.sh
#!/bin/bash
set -e
SCRIPTDIR="$(pwd)"
echo ">>> Cleaning up any previous build attempts..."
rm -rf ~/libewf-* ~/bulk_extractor-* ~/libewf.tar.gz ~/bulk_extractor.tar.gzcat << 'EOF' > install_bulk_extractor.sh
#!/bin/bash
set -e
SCRIPTDIR="$(pwd)"

echo ">>> Cleaning up previous build attempts..."
rm -rf ~/libewf-* ~/bulk_extractor-* ~/libewf.tar.gz ~/bulk_extractor.tar.gz

echo ">>> Installing build tools & dependencies..."
sudo yum groupinstall "Development Tools" -y
sudo yum install -y git wget unzip autoconf automake libtool \
  openssl-devel zlib-devel bzip2-devel pkgconfig

echo ">>> Cloning libewf from GitHub..."
cd ~
git clone https://github.com/libyal/libewf.git
cd libewf
./autogen.sh || true
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


echo ">>> Installing build tools & dependencies..."
sudo yum groupinstall "Development Tools" -y
sudo yum install -y git wget unzip autoconf automake libtool \
  openssl-devel zlib-devel bzip2-devel pkgconfig

echo ">>> Downloading libewf (clone from GitHub)..."
cd ~
git clone https://github.com/libyal/libewf.git
cd libewf
./autogen.sh || true   # some versions require this
./configure
make
sudo make install
sudo ldconfig

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
