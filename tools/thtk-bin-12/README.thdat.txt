THDAT(1)                  BSD General Commands Manual                 THDAT(1)

NAME
     thdat — Touhou archive tool

SYNOPSIS
     thdat [-V] [[-c | -l | -x] [d | version]] [archive [file ...]]

DESCRIPTION
     The thdat utility extracts files from an archive or creates a new archive
     from a set of files.  The following commands are available:

     thdat -c version archive file [file ...]
             Archives the specified files.

     thdat -l [d | version] archive
             Lists the contents of the archive.

     thdat -x [d | version] archive [file ...]
             Extracts files.  If no files are specified, all files are ex‐
             tracted.

     thdat -V
             Displays the program version.

     The version specifies which archive format to use.  Running the program
     without a command will list the supported formats.  If d is specified
     instead of version, thdat automatically detects the file format.

ENVIRONMENT
     OMP_NUM_THREADS  The number of threads to be used for compression and de‐
                      compression.  The default used when OMP_NUM_THREADS is
                      not set depends on the OpenMP implementation.

EXIT STATUS
     The thdat utility exits with 0 on success, 1 on error.

EXAMPLES
     Create a new archive from the input files:

           thdat -c6 output.dat input.anm input.msg input.ecl

     Lists the contents of the specified archive:

           thdat -l128 th128.dat

     Extract all files from the archive to the current working directory:

           thdat -x8 th08.dat

SEE ALSO
     Project homepage: https://github.com/thpatch/thtk

CAVEATS
     BGM archives are not supported by the thdat utility.

BUGS
     The format used by TH03-TH05 uses separate encryption keys for each entry
     in the archives, as well as one key for the entry list.  It is not known
     if these keys are computed from the entries, or if they are randomly as‐
     signed.  They are currently set to constant values.

     Original TH08 and TH09 archives contain a large amount of encrypted zero
     padding at the end of the entry list.  This padding is reduced to four
     bytes.

SECURITY CONSIDERATIONS
     File names may not be properly sanitized when extracting.  Furthermode,
     invalid data may not be properly handled.  Do not extract untrusted ar‐
     chives.

thtk                            April 16, 2018                            thtk
