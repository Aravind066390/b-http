CC      ?= gcc
CFLAGS  ?= -Wall -Wextra -O2 -std=c11
INCDIR  = include
SRCDIR  = src
OBJDIR  = build
TARGET  = server
SRC     = $(wildcard $(SRCDIR)/*.c)
OBJS    = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRC))
DEPS    = $(OBJS:.o=.d)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $^

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -I$(INCDIR) -MMD -MP -c $< -o $@

-include $(DEPS)

clean:
	rm -rf $(OBJDIR) $(TARGET)
