// C++11 lldiv() test
// __LONG_LONG_SUPPORTED

#include <stdlib.h>
#include <iostream>

int main()
{
    lldiv_t ll;
    long long x = 30;
    long long y = 10;

    ll = lldiv( 30, 10 );

    std::cout << x << " / " << y << " = "
              << "( " << ll.quot << ", " << ll.rem << " )" << "\n";

    return 0;
}
