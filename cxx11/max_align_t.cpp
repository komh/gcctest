// C++11 std::max_align_t test. See include/c++/4.9.x/cstddef

#include <cstddef>
#include <iostream>

int main()
{
    std::cout << "sizeof(std::max_align_t) = "
              << sizeof(std::max_align_t) << "\n";
    std::cout << "alignof(std::max_align_t) = "
              << alignof(std::max_align_t) << "\n";

    return 0;
}
