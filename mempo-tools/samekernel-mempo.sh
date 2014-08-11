

echo "-------------------------------------------"
echo "The Mempo's version"
echo "-------------------------------------------"

cd ~
rm -rf deterministic-kernel/
git clone https://github.com/mempo/deterministic-kernel.git
cd deterministic-kernel/

LANG=C git tag -v `git describe --tags`

echo "if signature is correct then press ENTER, else Ctrl-C to abort"
read _

bash run.sh

