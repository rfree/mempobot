
git-gpg-check: git-gpg-check.cpp
	g++ git-gpg-check.cpp -o git-gpg-check

run: git-gpg-check
	echo "Testing on test1: (should be badsig)"
	./git-gpg-check -c < test1.txt && echo "OK" || echo "badsig"
	echo
	echo
	echo "Testing on test4 (should be badsig)"
	./git-gpg-check -c < test4.txt && echo "OK" || echo "badsig"
	echo
	echo
	echo "Testing on test5:"
	./git-gpg-check -c < test5.txt && echo "OK" || echo "badsig"
	echo
	echo
	echo "Testing on test6:"
	./git-gpg-check -c < test6.txt && echo "OK" || echo "badsig"
	echo
	echo

