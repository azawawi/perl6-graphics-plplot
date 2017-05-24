
use v6;

unit class Graphics::PLplot;

use NativeCall;
use Graphics::PLplot::Raw;

has Str $.device;
has Str $.file-name;

method init {
    # Set output device
    plsdev($!device);

    # Set Output device and filename (if set)
    plsfnam($!file-name) if $!file-name;

    # Initialize plplot
    plinit;
}

method viewport($xmin, $xmax, $ymin, $ymax, $just, $axis) {
    plenv( $xmin.Num, $xmax.Num, $ymin.Num, $ymax.Num, $just, $axis );
}

method label(Str $xlabel, Str $ylabel, Str $tlabel) {
    pllab( $xlabel, $ylabel, $tlabel );
}

# Plot the data
method line(Int $size, @x, @y) {
    my $x = CArray[num64].new;
    my $y = CArray[num64].new;
    for 0..$size -> $i {
        $x[$i] = @x[$i];
        $y[$i] = @y[$i];
    }

    plline( $size, $x, $y );
}

method cleanup {
    # Close PLplot library
    plend;
}
