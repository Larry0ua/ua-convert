// compile with: g++.exe offset.cpp clipper.cpp -o offset.exe -static-libgcc -static-libstdc++
#include <cmath>
#include <ctime>
#include <cstdlib>
#include <cstdio>
#include <vector>
#include <iomanip>
#include <iostream>
#include <fstream>

#include "clipper.hpp"

#define MUL 1e7

using namespace std;

int main(int argc, char* argv[]) {
	if (argc != 3) {
		cout<<"Usage: offset.exe <input.poly> <output.poly>\n\n  Input and output files should be different.\n  Only one ring poly files are accepted now without inner rings.\n  Default offset is 0.001 degree\n";
		return 0;

	}
	ifstream f(argv[1], ifstream::in);
	ofstream outfile(argv[2], ofstream::out);
	outfile.precision(9);
	string s;
	for (int i=0;i<3;i++) {
		getline(f, s);
		outfile<<s<<"\n";
	}
	ClipperLib::Polygons polygons;
	ClipperLib::Polygon polygon;
	while(!f.eof()) {
		f>>s;
		if (s == "END") {
			break;
		}
		double c1 = ::atof(s.c_str());
		f>>s;
		double c2 = ::atof(s.c_str());
		ClipperLib::IntPoint point(c1 * MUL, c2 * MUL);
		polygon.push_back(point);
	}
	polygons.push_back(polygon);
	double distance = 0.001 * MUL;

	ClipperLib::Polygons res_polygons;
	ClipperLib::OffsetPolygons (polygons, res_polygons, distance, ClipperLib::jtMiter);

	if (res_polygons.size() < 1) { cerr<<"Bad output of OffsetPolygons!\n";return 1;}
	ClipperLib::Polygon result = res_polygons.front();

	for (ClipperLib::Polygon::iterator it = result.begin(); it != result.end(); ++it) {
		ClipperLib::IntPoint point = *it;
		outfile << "   " << (point.X/MUL) << "   " << (point.Y/MUL) << " \n";
	}

	outfile<<s;
	while (!f.eof()) {
		getline(f, s);
		outfile<<s<<"\n";
	}

	return 0;
}