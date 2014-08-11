
echo "***************************************************************"
echo "using RFREE version"
echo "***************************************************************"

cd ~
rm -rf deterministic-kernel/
git clone https://github.com/rfree/deterministic-kernel.git
cd deterministic-kernel/

LANG=C git tag -v `git describe --tags`

echo "if signature is correct then press ENTER, else Ctrl-C to abort"
read _

bash run.sh

echo ""
echo "That was RFREE version"
echo "DO NOT FORGET TO HAVE MEMPO PUBLISH IN OFFICIAL REPO"
echo ""

