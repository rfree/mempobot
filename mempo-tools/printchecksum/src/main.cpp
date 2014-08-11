#include <iostream>
#include <string>
using namespace std;

int main() {
	while (cin.good() && !cin.eof()) {
		string s;
		getline(cin,s);
		bool in_checksum=true;
		bool written_anything=false;
		for (size_t n=0; n<s.size(); ++n) {
			char c = s.at(n);
			if (c==' ') in_checksum=false;
			cout << c;
			written_anything = true;
			if (in_checksum) {
				if (!( (n+1)%(4))) cout << ' ';
				if (!( (n+1)%(4*4))) cout << "  ";
			}
		}
		if (written_anything) cout << endl;
	}
}

