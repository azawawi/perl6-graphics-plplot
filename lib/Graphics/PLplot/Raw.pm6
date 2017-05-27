
use v6;

unit module Graphics::PLplot::Raw;

use NativeCall;

# Types:
# http://plplot.sourceforge.net/docbook-manual/plplot-html-5.12.0/c.html 


sub library {
    return "libplplotd.so";
}

sub plsdev(Str)
    is symbol('c_plsdev')
    is native(&library)
    is export { * }

sub plsfnam(Str)
    is symbol('c_plsfnam')
    is native(&library)
    is export { * }

sub plparseopts(Pointer, Pointer, int32) returns int32
    is symbol('c_plparseopts')
    is native(&library)
    is export { * }

sub plinit 
    is symbol('c_plinit')
    is native(&library)
    is export { * }

sub plgver(CArray[int8])
    is symbol('c_plgver')
    is native(&library)
    is export { * }

sub plenv(num64, num64, num64, num64, int32, int32)
    is symbol('c_plenv')
    is native(&library)
    is export { * }

sub pllab(Str, Str, Str)
    is symbol('c_pllab')
    is native(&library)
    is export { * }

sub plline(int32, CArray[num64], CArray[num64])
    is symbol('c_plline')
    is native(&library)
    is export { * }

sub plend
    is symbol('c_plend')
    is native(&library)
    is export { * }

sub plsori(int32)
    is symbol('c_plsori')
    is native(&library)
    is export { * }

sub plarc(num64, num64, num64, num64, num64, num64, num64, int32)
    is symbol('c_plarc')
    is native(&library)
    is export { * }

sub plcol0(int32)
    is symbol('c_plcol0')
    is native(&library)
    is export { * }

sub pljoin(num64, num64, num64, num64)
    is symbol('c_pljoin')
    is native(&library)
    is export { * }

sub plptex(num64, num64, num64, num64, num64, Str)
    is symbol('c_plptex')
    is native(&library)
    is export { * }


sub plmtex(Str, num64, num64, num64, Str)
    is symbol('c_plmtex')
    is native(&library)
    is export { * }

sub plssub(int32, int32)
    is symbol('c_plssub')
    is native(&library)
    is export { * }

sub plvpor(num64, num64, num64, num64)
    is symbol('c_plvpor')
    is native(&library)
    is export { * }

sub plwind(num64, num64, num64, num64)
    is symbol('c_plwind')
    is native(&library)
    is export { * }

sub plbox(Str, num64, int32, Str, num64, int32)
    is symbol('c_plbox')
    is native(&library)
    is export { * }

sub plwidth(num64)
    is symbol('c_plwidth')
    is native(&library)
    is export { * }

sub plschr(num64, num64)
    is symbol('c_plschr')
    is native(&library)
    is export { * }

sub plfont(int32)
    is symbol('c_plfont')
    is native(&library)
    is export { * }

sub plbop
    is symbol('c_plbop')
    is native(&library)
    is export { * }

sub pleop
    is symbol('c_pleop')
    is native(&library)
    is export { * }

sub pladv(int32)
    is symbol('c_pladv')
    is native(&library)
    is export { * }

sub plhlsrgb(num64, num64, num64, num64 is rw, num64 is rw, num64 is rw)
    is symbol('c_plhlsrgb')
    is native(&library)
    is export { * }

sub plgcol0(int32, int32 is rw, int32 is rw, int32 is rw)
    is symbol('c_plgcol0')
    is native(&library)
    is export { * }

sub plscmap0(CArray[int32], CArray[int32], CArray[int32], int32)
    is symbol('c_plscmap0')
    is native(&library)
    is export { * }
