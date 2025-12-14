#include <iostream>
#include <format>
#include <fstream>
#include <string>
#include <vector>
#include <queue>

using namespace std;

void flood_fill_outside(std::vector<std::vector<char>>& board, int maxX, int maxY)
{
    const int H = maxY + 2;
    const int W = maxX + 2;

    std::queue<std::pair<int,int>> q;

    q.emplace(0, 0);
    board[0][0] = 'O';

    const int dx[4] = { 1, -1, 0, 0 };
    const int dy[4] = { 0, 0, 1, -1 };

    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();

        for (int d = 0; d < 4; ++d) {
            int nx = x + dx[d];
            int ny = y + dy[d];

            if (nx < 0 || ny < 0 || nx >= W || ny >= H)
                continue;

            if (board[ny][nx] == '.') {
                board[ny][nx] = 'O';
                q.emplace(nx, ny);
            }
        }
    }

    for (int y = 0; y < H; ++y) {
        for (int x = 0; x < W; ++x) {
            if (board[y][x] == '.') board[y][x] = 'X';
        }
    }
}

long long get_area(const tuple<int, int> &t1, const tuple<int, int> &t2) {
    return static_cast<long long>(abs(get<0>(t1) - get<0>(t2) + 1)) * static_cast<long long>(abs(get<1>(t1) - get<1>(t2) + 1));
}

string pos_str(const tuple<int, int> &t1) {
    return format("{} {}", get<0>(t1), get<1>(t1));
}

void print_board(vector<vector<char>> board, int maxX, int maxY) {
    for (int y = 0; y <= maxY + 1; y++) {
        for (int x = 0; x <= maxX + 1; x++) {
            cout << board[y][x] << " ";
        }
        cout << endl;
    }
}

bool all_contain_xs(const vector<vector<char>> & board, vector<tuple<int, int>>::const_reference p1, vector<tuple<int, int>>::const_reference p2) {
    int minX = min(get<0>(p1), get<0>(p2));
    int maxX = max(get<0>(p1), get<0>(p2));
    int minY = min(get<1>(p1), get<1>(p2));
    int maxY = max(get<1>(p1), get<1>(p2));

    for (int y = minY; y <= maxY; y++) {
        for (int x = minX; x <= maxX; x++) {
            if (board[y][x] != 'X') {
                return false;
            }
        }
    }
    return true;
}

bool all_contain_xs_fast(
    const vector<vector<int>>& prefix,
    const tuple<int,int>& p1,
    const tuple<int,int>& p2
) {
    int minX = min(get<0>(p1), get<0>(p2));
    int maxX = max(get<0>(p1), get<0>(p2));
    int minY = min(get<1>(p1), get<1>(p2));
    int maxY = max(get<1>(p1), get<1>(p2));

    int area = (maxX - minX + 1) * (maxY - minY + 1);
    return prefix[maxY+1][maxX+1]
         - prefix[minY][maxX+1]
         - prefix[maxY+1][minX]
         + prefix[minY][minX] == area;
}

int main() {
    vector<tuple<int, int>> positions;
    int maxX = 0;
    int maxY = 0;
    if (ifstream filestream ("input.txt"); filestream.is_open())
    {
        string line;
        while ( getline (filestream,line) )
        {
            const int x = stoi(line.substr(0, line.find(',')));
            const int y = stoi(line.substr(line.find(',') + 1));

            positions.emplace_back(x, y);

            if (x > maxX) maxX = x;
            if (y > maxY) maxY = y;
        }
        filestream.close();
    }
    else cout << "Unable to open file" << endl;

    cout<<maxX<<" "<<maxY<<endl;

    vector<vector<char>> board;
    for (int y = 0; y <= maxY + 1; y++) {
        board.emplace_back(maxX + 2, '.');
    }
    for (int i = 0; i < positions.size(); i++) {
        auto p1 = positions[i];
        auto p2 = positions[(i + 1) % positions.size()];
        int xdir = get<0>(p2) - get<0>(p1) > 0 ? 1 : -1;
        int ydir = get<1>(p2) - get<1>(p1) > 0 ? 1 : -1;
        if (get<0>(p2) - get<0>(p1) == 0) {
            for (int y = get<1>(p1); y != get<1>(p2); y += ydir) {
                board[y][get<0>(p2)] = 'X';
            }
        } else {
            for (int x = get<0>(p1); x != get<0>(p2); x += xdir) {
                board[get<1>(p2)][x] = 'X';
            }
        }
    }

    // print_board(board, maxX, maxY);
    flood_fill_outside(board, maxX, maxY);

    // print_board(board, maxX, maxY);

    vector prefixboard(maxY + 2, vector(maxX + 2, 0));

    for (int y = 1; y <= maxY + 1; ++y) {
        for (int x = 1; x <= maxX + 1; ++x) {
            int val = board[y-1][x-1] == 'X';
            prefixboard[y][x] = val
                + prefixboard[y-1][x]
                + prefixboard[y][x-1]
                - prefixboard[y-1][x-1];
        }
    }

    cout << "board constructed" << endl;

    long long biggestarea = 0;
    for (int i = 0; i < positions.size(); i++) {
        for (int j = i + 1; j < positions.size(); j++) {
            long long thisarea = get_area(positions[i], positions[j]);
            if (thisarea > biggestarea && all_contain_xs_fast(prefixboard, positions[i], positions[j])) {
                biggestarea = thisarea;
                cout << (i + 1.0f)/positions.size() << " " << biggestarea << endl;
            }
        }
    }

    cout << biggestarea << endl;

    return 0;
}
