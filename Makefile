SHELL = sh.exe

.SUFFIXES: .c .cpp .o .obj .exe .sym

CC := gcc
CXX := g++
CFLAGS :=
CXXFLAGS :=

LD := g++
LDFLAGS :=

RM := rm -f

TEST_DIRS := . c99 c11 cext cxx11
TEST_SRCS := $(foreach d,$(TEST_DIRS),$(wildcard $(d)/*.c) $(wildcard $(d)/*.cpp))
TEST_OBJS := $(foreach s,$(TEST_SRCS),$(s:$(suffix $(s))=.o))
TEST_EXES := $(TEST_OBJS:.o=.exe)

CLEAN_ETC :=

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.obj : %.c
	$(CC) $(CFLAGS) -Zomf -c -o $@ $<

%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.obj : %.cpp
	$(CXX) $(CXXFLAGS) -Zomf -c -o $@ $<

%.exe : %.o
	$(LD) $(LDFLAGS) -o $@ $^
	./$@ > /dev/null

%.exe : %.obj
	$(LD) $(LDFLAGS) -Zomf -o $@ $^

.PHONY: all clean

all : $(TEST_EXES)

c99/%.o : CFLAGS += -std=c99

c11/%.o : CFLAGS += -std=c11

cxx11/%.o : CXXFLAGS += -std=c++11

callconv.o : callconv.c
	$(CC) $(CFLAGS) -c -o $@ $<
	emxexp $@ > $(@:.o=.sym)

CLEAN_ETC += callconv.sym

xs.exe : xs.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^
	./$@ > /dev/null
	$(CXX) -Zomf $(CXXFLAGS) $(LDFLAGS) $^
	./$@ > /dev/null

clean :
	$(RM) $(TEST_OBJS)
	$(RM) $(TEST_EXES)
	$(RM) $(CLEAN_ETC)

