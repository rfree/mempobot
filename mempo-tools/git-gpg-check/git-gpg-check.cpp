#include <iostream>
#include <string>
#include <vector>

using namespace std;

int execute_check_validity() {
	bool got_good=false; // gpg: Good signature from "rfree-mempo (rfree for signing things in mempo, for now. low-medium security currently) <rfree@i2pmail.org>"
	bool got_made=false; // gpg: Signature made Tue 28 Oct 2014 03:17:32 CET using RSA key ID 45953F23
	bool got_warn=false; // gpg: WARNING: This key is not certified with a trusted signature!

	const string str_good="gpg: Good signature from ";
	const string str_made="gpg: Signature made ";
	const string str_warn="gpg: WARNING:";

	while (!cin.eof() && cin.good()) {
		string line;
		getline(cin,line);
		// cout << line << endl;

		got_good |= (line.find(str_good)==0);
		got_made |= (line.find(str_made)==0);
		got_warn |= (line.find(str_warn)==0);
	}
	
	bool success=0;
	if (got_good && got_made) success=1;
	if (got_warn) success=0;

	if (! success) return 1;
	return 0;
}

int main_(string program_name, vector<string> args) {
	typedef enum { execute_check_validity_enum, execute_none_enum, execute_help_enum } execute_type;
	execute_type execute = execute_none_enum;

	cout << "program " << program_name << endl;

	if (args.size()>0) cout << "arg0 = " << args.at(0) << endl;


}


int main(int argc, const char **argv) {
	string program_name;
	vector<string> args;
	if (argc>=0) program_name=argv[0];
	for (int i=1; i<argc; ++i) {
		args.push_back(argv[i]);
	}

	return main_(program_name, args);

}


