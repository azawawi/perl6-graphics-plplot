#!/usr/bin/env perl6

use v6;

use lib 'lib';
use Graphics::PLplot::Raw;
use NativeCall;

constant NSIZE = 101;

my $xmin = 0.0e0;
my $xmax = 1.0e0;
my $ymin = 0.0e0;
my $ymax = 100.0e0;

#my $ver = CArray[int8];
#plgver( $ver );
#say sprintf( "PLplot library version: %s\n", $ver );

my $x = CArray[num64].new;
my $y = CArray[num64].new;

# Prepare data to be plotted.
for 0..NSIZE -> $i {
    $x[$i] = Num($i) / ( NSIZE - 1 );
    $y[$i] = Num($ymax * $x[$i] * $x[$i]);
}

# Set Output device and filename
plsdev("png");
plsfnam("output.png");

# Initialize plplot
plinit;


# Create a labelled box to hold the plot.
plenv( $xmin, $xmax, $ymin, $ymax, Int(0), Int(0) );
pllab( "x", "y=100 x#u2#d", "Simple PLplot demo of a 2D line plot" );

# Plot the data that was prepared above.
plline( NSIZE, $x, $y );

# Close PLplot library
plend;
