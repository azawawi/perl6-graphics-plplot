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
use Graphics::PLplot;

if Graphics::PLplot.new(
    device    => "png",
    file-name => "output.png"
) -> $plot  {

    # Initialize plot
    $plot.begin;

    # Create a labelled box to hold the plot.
    my ($xmin, $xmax, $ymin, $ymax) = (0.0, 1.0, 0.0, 100);
    $plot.environment( $xmin, $xmax, $ymin, $ymax, 0, 0 );
    $plot.label("x", "y=100 x#u2#d", "Simple PLplot demo of a 2D line plot" );

    # Prepare data to be plotted.
    my @x;
    my @y;
    constant NSIZE = 101;
    for 0..^NSIZE -> $i {
        my $x = Num($i) / ( NSIZE - 1 );
        @x.push: $x;
        @y.push: Num($ymax * $x * $x);
    }

    # Plot the data that was prepared above.
    $plot.line(@x, @y);

    LEAVE {
        $plot.end;
    }
}
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
