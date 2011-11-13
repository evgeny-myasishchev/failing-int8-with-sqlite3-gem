SRCS = main.c
OBJS = main.o
TARGET = main

CLEAN = *.o main

CFLAGS = -g -O2
INCFLAGS = -I.
LIBPATH =
LIBS = -lsqlite3
LDFLAGS = -Wl

CC = gcc

RM = rm -f

all: $(TARGET)

clean:
	@-$(RM) $(CLEAN)

$(TARGET): $(OBJS) Makefile
	@-$(RM) $@
	$(CC) -o $@ $(OBJS) $(LIBPATH) $(LDFLAGS) $(LIBS)

.c.o:
	$(CC) $(INCFLAGS) $(CFLAGS) -c $<
