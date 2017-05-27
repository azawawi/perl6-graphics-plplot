
#
# Multiple window and color map 0 demo.
# Original C code is found at http://plplot.sourceforge.net/examples.php?demo=02
#
# Demonstrates multiple windows and color map 0 palette, both default and
# user-modified.
#

use v6;
use lib 'lib';
use Graphics::PLplot::Raw;

#--------------------------------------------------------------------------
# draw_windows
#
# Draws a set of numbered boxes with colors according to cmap0 entry.
#--------------------------------------------------------------------------
sub draw_windows( Int $nw, Int $cmap0-offset )
{
    plschr( 0.0.Num, 3.5.Num );
    plfont( 4 );

    for 0..^$nw -> $i {
        plcol0( $i + $cmap0-offset );
        my $text = sprintf( "%d", $i );
        pladv( 0 );
        my $vmin = 0.1;
        my $vmax = 0.9;
        for 0..2 -> $j {
            plwidth( ($j + 1).Num );
            plvpor( $vmin.Num, $vmax.Num, $vmin.Num, $vmax.Num );
            plwind( 0.0.Num, 1.0.Num, 0.0.Num, 1.0.Num );
            plbox( "bc", 0.0.Num, 0, "bc", 0.0.Num, 0 );
            $vmin += 0.1;
            $vmax -= 0.1;
        }
        plwidth( 1.Num );
        plptex( 0.5.Num, 0.5.Num, 1.0.Num, 0.0.Num, 0.5.Num, $text );
    }
}

#--------------------------------------------------------------------------
# demo1
#
# Demonstrates multiple windows and default color map 0 palette.
#--------------------------------------------------------------------------
sub demo1 {
    plbop;

    # Divide screen into 16 regions
    plssub( 4, 4 );

    draw_windows( 16, 0 );

    pleop;
}

#--------------------------------------------------------------------------
# demo2
#
# Demonstrates multiple windows, user-modified color map 0 palette, and
# HLS -> RGB translation.
#--------------------------------------------------------------------------
sub demo2 {
    
}

# Set Output device and filename
plsdev("png");
plsfnam("ex02.png");

# Initialize plplot
plinit;

# Run demos
demo1;
demo2;

plend;

=finish

void demo2( void )
{
// Set up cmap0
// Use 100 custom colors in addition to base 16
    PLINT r[116], g[116], b[116];

// Min & max lightness values
    PLFLT lmin = 0.15, lmax = 0.85;

    int   i;

    plbop();

// Divide screen into 100 regions

    plssub( 10, 10 );

    for ( i = 0; i <= 99; i++ )
    {
        PLFLT h, l, s;
        PLFLT r1, g1, b1;

        // Bounds on HLS, from plhlsrgb() commentary --
        //	hue		[0., 360.]	degrees
        //	lightness	[0., 1.]	magnitude
        //	saturation	[0., 1.]	magnitude
        //

        // Vary hue uniformly from left to right
        h = ( 360. / 10. ) * ( i % 10 );
        // Vary lightness uniformly from top to bottom, between min & max
        l = lmin + ( lmax - lmin ) * ( i / 10 ) / 9.;
        // Use max saturation
        s = 1.0;

        plhlsrgb( h, l, s, &r1, &g1, &b1 );
        //printf("%3d %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f\n",
        //     i+16,h,l,s,r1,g1,b1);

        // Use 255.001 to avoid close truncation decisions in this example.
        r[i + 16] = (PLINT) ( r1 * 255.001 );
        g[i + 16] = (PLINT) ( g1 * 255.001 );
        b[i + 16] = (PLINT) ( b1 * 255.001 );
    }

// Load default cmap0 colors into our custom set
    for ( i = 0; i <= 15; i++ )
        plgcol0( i, &r[i], &g[i], &b[i] );

//    for (i = 0; i < 116; i++)
//      printf("%3d %3d %3d %3d \n", i, r[i], g[i], b[i]);
// Now set cmap0 all at once (faster, since fewer driver calls)
    plscmap0( r, g, b, 116 );

    draw_windows( 100, 16 );

    pleop();
}
