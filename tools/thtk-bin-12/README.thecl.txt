THECL(1)                  BSD General Commands Manual                 THECL(1)

NAME
     thecl — Touhou enemy control language script tool

SYNOPSIS
     thecl [-Vr] [[-c | -h | -d] version] [-m eclmap]... [input [output]]

DESCRIPTION
     The thecl utility (de)compiles ecl scripts.  The following commands are
     available:

     thecl -c version [-s] [-m eclmap]... [input [output]]
             Compiles an enemy script.

     thecl -h version [-m eclmap]... [input [output]]
             Creates a header file with forward declarations of all subs in
             input.

     thecl -d version [-r] [-m eclmap]... [input [output]]
             Dumps an enemy script.

     -V      Displays the program version.

     These options are accepted:

     -m eclmap
             The -m option can be used to map ins_* to human readable names.

     -r      The -r option suppresses code transformations like parameter de‐
             tection, or expression decompilation.

     -s      The -s option enables simple creation mode, which doesn't add any
             instructions automatically.

     Replace the version option by the enemy script format version requested.
     Running the program without a command will list the supported formats.

EXIT STATUS
     The thecl utility exits with 0 on success, 1 on error.

SEE ALSO
     Project homepage: https://github.com/thpatch/thtk

SECURITY CONSIDERATIONS
     Invalid data may not be properly handled.  Do not operate on untrusted
     files.

thtk                           October 27, 2019                           thtk
