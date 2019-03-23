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
TEST_EXES := $(TEST_OBJS:.o=.exe) $(TEST_OBJS:.o=_omf.exe)

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

%_omf.exe : %.obj
	$(LD) $(LDFLAGS) -Zomf -o $@ $^
	./$@ > /dev/null

.PHONY: all clean

all : $(TEST_EXES)

c99/%.o   : CFLAGS += -std=c99
c99/%.obj : CFLAGS += -std=c99

c11/%.o   : CFLAGS += -std=c11
c11/%.obj : CFLAGS += -std=c11

cxx11/%.o   : CXXFLAGS += -std=c++11
cxx11/%.obj : CXXFLAGS += -std=c++11

callconv.o : callconv.c
	$(CC) $(CFLAGS) -c -o $@ $<
	emxexp $@ > $(@:.o=.sym)

CLEAN_ETC += callconv.sym

stack_protector_strong.o  : CFLAGS += -fstack-protector-strong
stack_protector_strong.obj: CFLAGS += -fstack-protector-strong

stack_protector_strong.exe    : LDFLAGS += -fstack-protector-strong
stack_protector_strong_omf.exe: LDFLAGS += -fstack-protector-strong

clean :
	$(RM) $(TEST_OBJS)
	$(RM) $(TEST_OBJS:.o=.obj)
	$(RM) $(TEST_EXES)
	$(RM) $(CLEAN_ETC)

