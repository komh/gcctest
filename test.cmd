setlocal
set LANG=C
make clean
make -i 2>&1 | tee test.log
echo ----- callconv.sym ----- >> test.log
type callconv.sym >> test.log
del callconv.sym
endlocal
