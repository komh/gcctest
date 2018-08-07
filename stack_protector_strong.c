/* -fstack-protector-strong test */

int main( void )
{
    int i = 0;

    {
        const char *sa[4];
        int j = 0;
    }

    return 0;
}
