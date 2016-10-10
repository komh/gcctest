// C++11 std::string test
// Workaround: g++ -std=c++11 -D_GLIBCXX_USE_C99 -D__LONG_LONG_SUPPORTED stol.cpp

#include <string>
#include <iostream>

using namespace std;

int main()
{
    string s = "42";
    cout << stol(s) <<endl;

    return 0;
}
