
use v6;

unit class Graphics::PLplot;

use NativeCall;
use Graphics::PLplot::Raw;

has Str $.device;
has Str $.file-name;

method begin {
    # Set output device
    plsdev($!device);

    # Set Output device and filename (if set)
    plsfnam($!file-name) if $!file-name;

    # Initialize plplot
    plinit;
}

method environment($xmin, $xmax, $ymin, $ymax, $just, $axis) {
    plenv( $xmin.Num, $xmax.Num, $ymin.Num, $ymax.Num, $just, $axis );
}

method label(Str $xlabel, Str $ylabel, Str $tlabel) {
    pllab( $xlabel, $ylabel, $tlabel );
}

# Plot the data
method line(@x, @y) {
    die "Input arrays must be equal in size" if @x.elems != @y.elems;

    my $xc   = CArray[num64].new;
    my $yc   = CArray[num64].new;
    my $size = @x.elems;
    for 0..^$size -> $i {
        $xc[$i] = @x[$i];
        $yc[$i] = @y[$i];
    }

    plline( $size, $xc, $yc );
}

method end {
    # Close PLplot library
    plend;
}
