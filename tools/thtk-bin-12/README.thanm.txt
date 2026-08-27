THANM(1)                  BSD General Commands Manual                 THANM(1)

NAME
     thanm — Touhou sprite archive tool

SYNOPSIS
     thanm [-Vf] [-l | -x | -r | -c] [archive [...]]

DESCRIPTION
     The thanm utility performs various actions on sprite archives.  The fol‐
     lowing commands are available:

     thanm -l [-f] archive
             Displays a specification of the archive.

     thanm -x [-f] archive [file ...]
             Extracts image files.  If no files are specified, all files are
             extracted.

     thanm -r [-f] archive name file
             Replaces an entry in the archive.  The name can be obtained by
             the -l command.

     thanm -c [-f] archive input
             Creates a new archive from a specification obtained by the -l
             command.  It will look for referenced image files in the current
             directory.

     thanm -V
             Displays the program version.

     These options are accepted:

     -f      The -f option can be used to ignore certain errors.

EXIT STATUS
     The thanm utility exits with 0 on success, 1 on error.

SEE ALSO
     Project homepage: https://github.com/thpatch/thtk

BUGS
     A few files from TH12 and TH13 contain overlapping entries with different
     formats.  Dumping and recreating these archives will not result in the
     same archives.  The affected pixels seem to all have 0 for alpha though.

     One of the scripts in TH95's front.anm lack a sentinel instruction.
     Dumping and recreating this archive will add a sentinel instruction.

SECURITY CONSIDERATIONS
     File names may not be properly sanitized when extracting.  Furthermode,
     invalid data may not be properly handled.  Do not operate on untrusted
     files.

thtk                            March 16, 2018                            thtk
