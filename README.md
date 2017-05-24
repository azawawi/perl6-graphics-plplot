# Graphics::PLplot

This module provides Perl 6 native bindings for
[PLplot](http://plplot.sourceforge.net/)

PLplot is a library of subroutines that are often used to make scientific plots
in various compiled languages. PLplot can also be used interactively by
interpreted languages such as Octave, Python, Perl and Tcl. The current version
was written primarily by Maurice J. LeBrun and Geoffrey Furnish and is licensed
under LGPL.

## Example

```Perl6
use v6;
use Graphics::PLplot;

```

For more examples, please see the [examples](examples) folder.

## Installation

* On Debian-based linux distributions, please use the following command:
```
$ sudo apt install libplplot-dev
```

* On Mac OS X, please use the following command:
```
$ brew update
$ brew install plplot
```

* Using zef (a module management tool bundled with Rakudo Star):
```
$ zef install Graphics::PLplot
```

## Testing

- To run tests:
```
$ prove -ve "perl6 -Ilib"
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove -e "perl6 -Ilib"
```

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

MIT
