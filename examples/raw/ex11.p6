#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NativeCall;
use Graphics::PLplot::Raw;

#
# Mesh plot demo.
#
# Original C code is found at http://plplot.sourceforge.net/examples.php?demo=11
#
# Does a series of mesh plots for a given data set, with different viewing
# options in each plot.
#


constant XPTS   = 35;            # Data points in x
constant YPTS   = 46;            # Data points in y
constant LEVELS = 10;

my @opt = DRAW_LINEXY, DRAW_LINEXY;
my @alt = 33.0, 17.0;
my @az  = 24.0, 115.0;

my @title =
    "#frPLplot Example 11 - Alt=33, Az=24, Opt=3",
    "#frPLplot Example 11 - Alt=17, Az=115, Opt=3";

sub cmap1-init {
    my $i = CArray[num64].new;
    $i[0] = 0.0;         # left boundary
    $i[1] = 1.0;         # right boundary

    my $h = CArray[int32].new;
    $h[0] = 240;         # blue -> green -> yellow ->
    $h[1] = 0;           # -> red

    my $l = CArray[num64].new;
    $l[0] = 0.6;
    $l[1] = 0.6;

    my $s = CArray[num64].new;
    $s[0] = 0.8;
    $s[1] = 0.8;

    plscmap1n(256);
    plscmap1l(0, 2, $i, $h, $l, $s, Pointer.new);
}

=finish

sub MAIN {
    PLFLT *x, *y, **z;
    PLFLT xx, yy;
    int   nlevel = LEVELS;
    PLFLT clevel[LEVELS];
    PLFLT zmin, zmax, step;

    # Set Output device
    plsdev("wxwidgets");

    # Initialize plplot
    plinit;

    x = (PLFLT *) calloc(XPTS, sizeof (PLFLT));
    y = (PLFLT *) calloc(YPTS, sizeof (PLFLT));

    plAlloc2dGrid(&z, XPTS, YPTS);
    for (i = 0; i < XPTS; i++)
    {
        x[i] = 3. * (PLFLT) (i - (XPTS / 2)) / (PLFLT) (XPTS / 2);
    }

    for (i = 0; i < YPTS; i++)
        y[i] = 3. * (PLFLT) (i - (YPTS / 2)) / (PLFLT) (YPTS / 2);

    for (i = 0; i < XPTS; i++)
    {
        xx = x[i];
        for (j = 0; j < YPTS; j++)
        {
            yy      = y[j];
            z[i][j] = 3. * (1. - xx) * (1. - xx) * exp(-(xx * xx) - (yy + 1.) * (yy + 1.)) -
                      10. * (xx / 5. - pow(xx, 3.) - pow(yy, 5.)) * exp(-xx * xx - yy * yy) -
                      1. / 3. * exp(-(xx + 1) * (xx + 1) - (yy * yy));

            if (0) # Jungfraujoch/Interlaken
            {
                if (z[i][j] < -1.)
                    z[i][j] = -1.;
            }
        }
    }

    plMinMax2dGrid((PLFLT_MATRIX) z, XPTS, YPTS, &zmax, &zmin);
    step = (zmax - zmin) / (nlevel + 1);
    for (i = 0; i < nlevel; i++)
        clevel[i] = zmin + step + step * i;

    cmap1-init;
    for (k = 0; k < 2; k++)
    {
        for (i = 0; i < 4; i++)
        {
            pladv(0);
            plcol0(1);
            plvpor(0.0, 1.0, 0.0, 0.9);
            plwind(-1.0, 1.0, -1.0, 1.5);
            plw3d(1.0, 1.0, 1.2, -3.0, 3.0, -3.0, 3.0, zmin, zmax, alt[k], az[k]);
            plbox3("bnstu", "x axis", 0.0, 0,
                "bnstu", "y axis", 0.0, 0,
                "bcdmnstuv", "z axis", 0.0, 4);

            plcol0(2);

            # wireframe plot
            if (i == 0)
                plmesh(x, y, (PLFLT_MATRIX) z, XPTS, YPTS, opt[k]);

            # magnitude colored wireframe plot
            else if (i == 1)
                plmesh(x, y, (PLFLT_MATRIX) z, XPTS, YPTS, opt[k] | MAG_COLOR);

            # magnitude colored wireframe plot with sides
            else if (i == 2)
                plot3d(x, y, (PLFLT_MATRIX) z, XPTS, YPTS, opt[k] | MAG_COLOR, 1);

            # magnitude colored wireframe plot with base contour
            else if (i == 3)
                plmeshc(x, y, (PLFLT_MATRIX) z, XPTS, YPTS, opt[k] | MAG_COLOR | BASE_CONT,
                    clevel, nlevel);

            plcol0(3);
            plmtex("t", 1.0, 0.5, 0.5, title[k]);
        }
    }

    # Clean up
    plFree2dGrid(z, XPTS, YPTS);
    plend;
}
