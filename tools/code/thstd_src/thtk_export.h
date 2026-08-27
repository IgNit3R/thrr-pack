
#ifndef THTK_EXPORT_H
#define THTK_EXPORT_H

#ifdef THTK_STATIC_DEFINE
#  define THTK_EXPORT
#  define THTK_NO_EXPORT
#else
#  ifndef THTK_EXPORT
#    ifdef thtk_EXPORTS
        /* We are building this library */
#      define THTK_EXPORT __declspec(dllexport)
#    else
        /* We are using this library */
#      define THTK_EXPORT __declspec(dllimport)
#    endif
#  endif

#  ifndef THTK_NO_EXPORT
#    define THTK_NO_EXPORT 
#  endif
#endif

#ifndef THTK_DEPRECATED
#  define THTK_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef THTK_DEPRECATED_EXPORT
#  define THTK_DEPRECATED_EXPORT THTK_EXPORT THTK_DEPRECATED
#endif

#ifndef THTK_DEPRECATED_NO_EXPORT
#  define THTK_DEPRECATED_NO_EXPORT THTK_NO_EXPORT THTK_DEPRECATED
#endif

/* NOLINTNEXTLINE(readability-avoid-unconditional-preprocessor-if) */
#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef THTK_NO_DEPRECATED
#    define THTK_NO_DEPRECATED
#  endif
#endif

#endif /* THTK_EXPORT_H */
