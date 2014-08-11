cd ~
rm -rf mempo-deb/
git clone https://github.com/mempo/mempo-deb
cd mempo-deb/pack/dpkg
LANG=C git tag -v `git describe --tags`

echo "if signature is correct then press ENTER, else Ctrl-C to abort"
read _

./build-and-install-locally.sh
