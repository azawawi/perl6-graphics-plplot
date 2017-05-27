#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NativeCall;
use Graphics::PLplot::Raw;

#
# 3D line and point plot demo.
#
# Original C code is found at http://plplot.sourceforge.net/examples.php?demo=18
#
# Does a series of 3-d plots for a given data set, with different
# viewing options in each plot.
#

sub MAIN {
    constant NPTS = 1000;

    my @opt = 1, 0, 1, 0;
    my @alt = 20.0, 35.0, 50.0, 65.0;
    my @az  = 30.0, 40.0, 50.0, 60.0;

    # Set Output device
    plsdev("wxwidgets");

    # Initialize plplot
    plinit;

    for ^4 -> $k {
        test-poly($k);
    }

    my $x = CArray[num64].new;
    my $y = CArray[num64].new;
    my $z = CArray[num64].new;

    # From the mind of a sick and twisted physicist...
    for 0..^NPTS -> $i {
        $z[$i] = (-1.0 + 2.0 * $i / NPTS).Num;
    
        # Pick one ...
        my $r = $z[$i];

        $x[$i] = ($r * cos(2.0 * pi * 6.0 * $i / NPTS)).Num;
        $y[$i] = ($r * sin(2.0 * pi * 6.0 * $i / NPTS)).Num;
    }
    for ^4 -> $k {
        pladv(0);
        plvpor(0.0.Num, 1.0.Num, 0.0.Num, 0.9.Num);
        plwind(-1.0.Num, 1.0.Num, -0.9.Num, 1.1.Num);
        plcol0(1);
        plw3d(1.0.Num, 1.0.Num, 1.0.Num, -1.0.Num, 1.0.Num, -1.0.Num, 1.0.Num, -1.0.Num, 1.0.Num, @alt[$k].Num, @az[$k].Num);
        plbox3("bnstu", "x axis", 0.0.Num, 0,
            "bnstu", "y axis", 0.0.Num, 0,
            "bcdmnstuv", "z axis", 0.0.Num, 0);

        plcol0(2);

        if (@opt[$k]) {
            plline3(NPTS, $x, $y, $z);
        }
        else {
            # U+22C5 DOT OPERATOR.
            plstring3(NPTS, $x, $y, $z, "⋅");
        }

        plcol0(3);
        my $title = sprintf("#frPLplot Example 18 - Alt=%.0f, Az=%.0f",
            @alt[$k], @az[$k]);
        plmtex("t", 1.0.Num, 0.5.Num, 0.5.Num, $title);
    }

    # Cleanup
    plend;
}

sub test-poly($k) {
    
}

=finish

sub test_poly($k) {
    PLINT draw[][4] = { { 1, 1, 1, 1 },
                        { 1, 0, 1, 0 },
                        { 0, 1, 0, 1 },
                        { 1, 1, 0, 0 } };

    pi = M_PI, two_pi = 2. * pi;

    x = (PLFLT *) malloc(5 * sizeof (PLFLT));
    y = (PLFLT *) malloc(5 * sizeof (PLFLT));
    z = (PLFLT *) malloc(5 * sizeof (PLFLT));

    pladv(0);
    plvpor(0.0, 1.0, 0.0, 0.9);
    plwind(-1.0, 1.0, -0.9, 1.1);
    plcol0(1);
    plw3d(1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, alt[k], az[k]);
    plbox3("bnstu", "x axis", 0.0, 0,
        "bnstu", "y axis", 0.0, 0,
        "bcdmnstuv", "z axis", 0.0, 0);

    plcol0(2);

#define THETA(a)    (two_pi * (a) / 20.)
#define PHI(a)      (pi * (a) / 20.1)

    for (i = 0; i < 20; i++)
    {
        for (j = 0; j < 20; j++)
        {
            x[0] = sin(PHI(j)) * cos(THETA(i));
            y[0] = sin(PHI(j)) * sin(THETA(i));
            z[0] = cos(PHI(j));

            x[1] = sin(PHI(j + 1)) * cos(THETA(i));
            y[1] = sin(PHI(j + 1)) * sin(THETA(i));
            z[1] = cos(PHI(j + 1));

            x[2] = sin(PHI(j + 1)) * cos(THETA(i + 1));
            y[2] = sin(PHI(j + 1)) * sin(THETA(i + 1));
            z[2] = cos(PHI(j + 1));

            x[3] = sin(PHI(j)) * cos(THETA(i + 1));
            y[3] = sin(PHI(j)) * sin(THETA(i + 1));
            z[3] = cos(PHI(j));

            x[4] = sin(PHI(j)) * cos(THETA(i));
            y[4] = sin(PHI(j)) * sin(THETA(i));
            z[4] = cos(PHI(j));

            plpoly3(5, x, y, z, draw[k], 1);
        }
    }

    plcol0(3);
    plmtex("t", 1.0, 0.5, 0.5, "unit radius sphere");
}
