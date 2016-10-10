// C++11 stdint.h/inttypes.h test
// __STDC_CONSTANT_MACROS and __STDC_LIMIT_MACROS

#include <inttypes.h>
#include <iostream>

int main()
{
    std::cout << "INT64_C ( 0 ) = " << INT64_C( 0 )
              << ", INTPTR_MAX = " << INTPTR_MAX << "\n";

    return 0;
}
