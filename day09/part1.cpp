#include <iostream>
#include <format>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

long long get_area(const tuple<int, int> &t1, const tuple<int, int> &t2) {
    return static_cast<long long>(abs(get<0>(t1) - get<0>(t2) + 1)) * static_cast<long long>(abs(get<1>(t1) - get<1>(t2) + 1));
}

string pos_str(const tuple<int, int> &t1) {
    return format("{} {}", get<0>(t1), get<1>(t1));
}


int main() {
    vector<tuple<int, int>> positions;
    if (ifstream filestream ("input.txt"); filestream.is_open())
    {
        string line;
        while ( getline (filestream,line) )
        {
            const int x = stoi(line.substr(0, line.find(',')));
            const int y = stoi(line.substr(line.find(',') + 1));

            positions.emplace_back(x, y);
        }
        filestream.close();
    }
    else cout << "Unable to open file" << endl;

    long long biggestarea = 0;
    for (int i = 0; i < positions.size(); i++) {
        for (int j = i + 1; j < positions.size(); j++) {
            long long thisarea = get_area(positions[i], positions[j]);
            if (thisarea > biggestarea) {
                biggestarea = thisarea;
            }
        }
    }

    cout << biggestarea << endl;

    return 0;
}