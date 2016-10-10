/* Calling convention test */

#include <stdio.h>

void _System sys( void )
{
    printf("_System should generate sys\n");
}

void _stdcall std( void )
{
    printf("_stdcall should generate _std@0\n");
}

void _fastcall fast( void )
{
    printf("_fastcall should generate @fast@0\n");
}

void _cdecl c( void )
{
    printf("_cdecl should be _c\n");
}

int main( void )
{
    __asm__ volatile("call sys");
    __asm__ volatile("call _std@0");
    __asm__ volatile("call @fast@0");
    __asm__ volatile("call _c");

    return 0;
}
