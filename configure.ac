#
# zmqing: ZMQ bindings for GAP
#
# This file is part of the build system of a GAP kernel extension.
# Requires GNU autoconf, GNU automake and GNU libtool.
#

dnl ##
dnl ## Setup autoconf
dnl ##
AC_PREREQ([2.68])
AC_INIT([zmqing], m4_esyscmd([tr -d '\n' < VERSION]))
AC_CONFIG_SRCDIR([src/zmqing.c])
AC_CONFIG_HEADER([src/pkgconfig.h:cnf/pkgconfig.h.in])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([cnf])
m4_include([m4/ac_find_gap.m4])

dnl ##
dnl ## Get canonical host info
dnl ##
AC_CANONICAL_HOST

dnl ##
dnl ## Setup automake
dnl ##
AM_INIT_AUTOMAKE([1.11 -Wall foreign subdir-objects])
AM_SILENT_RULES([yes])
AM_PROG_AR

dnl ##
dnl ## Set the language
dnl ##
AC_PROG_CC
AC_LANG([C])

dnl ##
dnl ## Setup libtool (for building the GAP kernel extension)
dnl ##
LT_PREREQ([2.4.2])
LT_INIT([disable-static dlopen win32-dll])

dnl ##
dnl ## Locate the GAP root dir
dnl ##
AC_FIND_GAP

dnl ##
dnl ## Detect pointer size to distinguish 32 and 64 bit builds
dnl ##
AC_CHECK_SIZEOF([void **])

dnl ##
dnl ## Detect Windows resp. Cygwin
dnl ##
case $host_os in
  *cygwin* ) CYGWIN=yes;;
         * ) CYGWIN=no;;
esac
AM_CONDITIONAL([SYS_IS_CYGWIN], [test "$CYGWIN" = "yes"])
if test "$CYGWIN" = "yes"; then
  AC_DEFINE(SYS_IS_CYGWIN32, 1, are we on CYGWIN?)
else
  AC_DEFINE(SYS_IS_CYGWIN32, 0, are we on CYGWIN?)
fi

dnl ##
dnl ## Detect ZeroMQ
dnl ##

was_libzmq_check_lib_detected=no

PKG_CHECK_MODULES([libzmq], [libzmq >= 3.0.0],
    [
        PKGCFG_LIBS_PRIVATE="$PKGCFG_LIBS_PRIVATE $libzmq_LIBS"
    ],
    [
        AC_ARG_WITH([libzmq],
            [
                AS_HELP_STRING([--with-libzmq],
                [Specify libzmq prefix])
            ],
            [search_libzmq="yes"],
            [])

        libzmq_synthetic_cflags=""
        libzmq_synthetic_libs="-lzmq"

        if test "x$search_libzmq" = "xyes"; then
            if test -r "${with_libzmq}/include/zmq.h"; then
                libzmq_synthetic_cflags="-I${with_libzmq}/include"
                libzmq_synthetic_libs="-L${with_libzmq}/lib -lzmq"
            else
                AC_MSG_ERROR([${with_libzmq}/include/zmq.h not found. Please check libzmq prefix])
            fi
        fi

        AC_CHECK_LIB([zmq], [zmq_init],
            [
                CFLAGS="${libzmq_synthetic_cflags} ${CFLAGS}"
                LDFLAGS="${libzmq_synthetic_libs} ${LDFLAGS}"
                LIBS="${libzmq_synthetic_libs} ${LIBS}"

                AC_SUBST([libzmq_CFLAGS],[${libzmq_synthetic_cflags}])
                AC_SUBST([libzmq_LIBS],[${libzmq_synthetic_libs}])
                was_libzmq_check_lib_detected=yes
                PKGCFG_LIBS_PRIVATE="$PKGCFG_LIBS_PRIVATE -lzmq"
            ],
            [AC_MSG_ERROR([cannot link with -lzmq, install libzmq])])
    ])

if test "x$was_libzmq_check_lib_detected" = "xno"; then
    CFLAGS="${libzmq_CFLAGS} ${CFLAGS}"
    LIBS="${libzmq_LIBS} ${LIBS}"
fi

dnl ##
dnl ## Rebuild configure if VERSION file changes
dnl ##
AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ['$(top_srcdir)/VERSION'])

dnl ##
dnl ## Output everything
dnl ##
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
