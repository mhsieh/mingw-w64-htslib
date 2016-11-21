# THIS IS THE MAKEFILE FOR CROSS-COMPILING HTSLIB FOR MINGW32/MINGW-W64 UNDER
# TRAVIS CI ENVIRONMENT
# AUTHOR: Mengjuei Hsieh
SRC      := $(shell pwd)
X64HOME  := $(SRC)/x64
I386HOME := $(SRC)/i386
CPP       = x86_64-w64-mingw32-cpp            
CXX       = x86_64-w64-mingw32-g++      -m64
 CC       = x86_64-w64-mingw32-gcc      -m64
 FC       = x86_64-w64-mingw32-gfortran -m64
F90       = x86_64-w64-mingw32-gfortran -m64
RANLIB    = x86_64-w64-mingw32-ranlib

debug:
	@echo X64HOME  = $(X64HOME)
	@echo I386HOME = $(I386HOME)
	@ls -l /usr/lib/gcc/i686-w64-mingw32/4.6/
	@ls -l /usr/lib/gcc/x86_64-w64-mingw32/4.6/

clean: uninstall
uninstall: 
	rm -rf x64 i386
x64:
	@cd $$HOME/.wine/drive_c/windows                              && \
        rm -f libstdc++-6.dll libgcc_s_sjlj-1.dll                        \
              libgfortran-3.dll libquadmath-0.dll                     && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libstdc++-6.dll     && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libgcc_s_sjlj-1.dll && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libgfortran-3.dll   && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libquadmath-0.dll   && \
        cd $(SRC)/zlib-1.2.8                                          && \
        test -e Makefile && $(MAKE) distclean || true                 && \
        ./configure                                                      \
            --static                                                     \
            --prefix=$(X64HOME) >> $(SRC)/config.log 2>&1             && \
        $(MAKE) install                                               && \
        ls /usr/lib/gcc/x86_64-w64-mingw32/4.6/                       && \
        cd -                                                          && \
        $(MAKE) -C $(SRC)/htslib                                         \
                   CC="$(CC)"                                            \
            ZLIB_ROOT=$(X64HOME)                                         \
               CFLAGS="-Wall -O2 -Wno-unused-function"                   \
             PLATFORM="MINGW-W64"
