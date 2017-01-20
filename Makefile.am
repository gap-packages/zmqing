#
# zmqing: ZMQ bindings for GAP
#
# This file is part of the build system of a GAP kernel extension.
# Requires automake.
#
ACLOCAL_AMFLAGS = -I m4

BINARCHDIR = bin/$(GAPARCH)
GAPINSTALLLIB = $(BINARCHDIR)/zmqing.so

lib_LTLIBRARIES = zmqing.la

zmqing_la_SOURCES = src/zmqing.c src/zmqgap.c src/zmqgap.h
zmqing_la_CPPFLAGS = $(GAP_CPPFLAGS) -DCONFIG_H
zmqing_la_LDFLAGS = -module -avoid-version
if SYS_IS_CYGWIN
zmqing_la_LDFLAGS += -no-undefined -version-info 0:0:0 
zmqing_la_LDFLAGS += -Wl,$(GAPROOT)/bin/$(GAPARCH)/gap.dll
endif

all-local: $(GAPINSTALLLIB)

$(GAPINSTALLLIB): zmqing.la
	$(mkdir_p) $(BINARCHDIR)
if SYS_IS_CYGWIN
	cp .libs/zmqing.dll $(GAPINSTALLLIB)
else
	cp .libs/zmqing.so $(GAPINSTALLLIB)
endif

clean-local:
	rm -f $(GAPINSTALLLIB)

distclean-local:
	rm -rf bin/*

doc:
	($(GAPROOT)/bin/gap.sh -A makedoc.g)
