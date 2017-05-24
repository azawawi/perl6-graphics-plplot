#!/usr/bin/env perl6

use v6;

use lib 'lib';
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
