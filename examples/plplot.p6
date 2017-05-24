#!/usr/bin/env perl6

use v6;

use lib 'lib';
use Graphics::PLplot;

given my $o = Graphics::PLplot.new(
    device    => "png",
    file-name => "output.png"
) {
    $o.init;

    # Create a labelled box to hold the plot.
    my ($xmin, $xmax, $ymin, $ymax) = (0.0, 1.0, 0.0, 100);
    .viewport( $xmin, $xmax, $ymin, $ymax, 0, 0 );
    .label("x", "y=100 x#u2#d", "Simple PLplot demo of a 2D line plot" );

    # Prepare data to be plotted.
    my @x;
    my @y;
    constant NSIZE = 101;
    for 0..NSIZE -> $i {
        @x.push: Num($i) / ( NSIZE - 1 );
        @y.push: Num($ymax * @x[$i] * @x[$i]);
    }

    # Plot the data that was prepared above.
    .line( NSIZE, @x, @y);

    LEAVE {
        .cleanup if $o;
    }
}
