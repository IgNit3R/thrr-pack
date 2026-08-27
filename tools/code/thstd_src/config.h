#ifndef THTK_CONFIG_H_
#define THTK_CONFIG_H_

/* Flex uses stdint.h if the compiler reports itself as C99. MSVC doesn't. */
#if !defined(__STDC_VERSION__) && defined(_MSC_VER)
# if _MSC_VER >= 1900
#  define __STDC_VERSION__ 199901L
# endif
#endif

#ifdef _MSC_VER
# define PRAGMA(x) __pragma(x)
#else
# define PRAGMA(x) _Pragma(#x)
#endif

/* #undef HAVE_PACKING_PRAGMA_PUSH */
#ifdef HAVE_PACKING_PRAGMA_PUSH
# define PACK_BEGIN PRAGMA(pack(push,1))
# define PACK_END PRAGMA(pack(pop))
#else
# define PACK_BEGIN
# define PACK_END
#endif

#define HAVE_PACKING_GNUC_ATTRIBUTE
#ifdef HAVE_PACKING_GNUC_ATTRIBUTE
#define PACK_ATTRIBUTE __attribute__((__packed__))
#else
#define PACK_ATTRIBUTE
#endif

#define PNG_FOUND
#ifdef PNG_FOUND
# define HAVE_LIBPNG
#endif

#define HAVE_SYS_TYPES_H
#define HAVE_OFF_T
#define HAVE_SSIZE_T
/* #undef HAVE_SSIZE_T_BASETSD */
#if !defined(HAVE_SSIZE_T) && defined(HAVE_SSIZE_T_BASETSD)
# include <basetsd.h>
typedef SSIZE_T ssize_t;
#endif
#define HAVE_UNISTD_H
#ifndef HAVE_UNISTD_H
# define YY_NO_UNISTD_H
#endif
#define HAVE_MMAP
#define HAVE_FSTAT
#define HAVE_SCANDIR
#define HAVE_FILENO
#define HAVE_CHDIR
/* #undef HAVE__CHDIR */
#define HAVE_PREAD

#define HAVE_GETC_UNLOCKED
#define HAVE_FREAD_UNLOCKED
#define HAVE_FEOF_UNLOCKED
/* #undef HAVE__GETC_NOLOCK */
/* #undef HAVE__FREAD_NOLOCK */
#ifndef HAVE_GETC_UNLOCKED
# ifdef HAVE__GETC_NOLOCK
#  define getc_unlocked _getc_nolock
#  define putc_unlocked _putc_nolock
# else
#  define getc_unlocked getc
#  define putc_unlocked putc
# endif
#endif
#ifndef HAVE_FREAD_UNLOCKED
# ifdef HAVE__FREAD_NOLOCK
#  define fread_unlocked _fread_nolock
#  define fwrite_unlocked _fwrite_nolock
# else
#  define fread_unlocked fread
#  define fwrite_unlocked fwrite
# endif
#endif
/* feof and fileno don't lock in VCRT, and thus they don't have _nolock versions. */
#ifndef HAVE_FEOF_UNLOCKED
# define feof_unlocked feof
# if defined(HAVE_FILENO)
#  define fileno_unlocked fileno
# endif
#endif
/* Our code shouldn't need to check these */
#undef HAVE_GETC_UNLOCKED
#undef HAVE_FREAD_UNLOCKED
#undef HAVE_FEOF_UNLOCKED
#undef HAVE__GETC_NOLOCK
#undef HAVE__FREAD_NOLOCK

#ifdef _WIN32
# include <io.h>
# include <fcntl.h>
#endif

#include <thtk_export.h>

#define PACKAGE_NAME "Touhou Toolkit"
#define PACKAGE_VERSION "12"
#define PACKAGE_BUGREPORT "https://github.com/thpatch/thtk/issues"

#endif
