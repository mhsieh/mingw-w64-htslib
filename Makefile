# THIS IS THE MAKEFILE FOR CROSS-COMPILING HTSLIB FOR MINGW32/MINGW-W64 UNDER
# TRAVIS CI ENVIRONMENT
# AUTHOR: Mengjuei Hsieh
SRC      := $(shell pwd)
X64HOME  := $(SRC)/x64
AR        = x86_64-w64-mingw32-ar
CPP       = x86_64-w64-mingw32-cpp            
CXX       = x86_64-w64-mingw32-g++      -m64
CC        = x86_64-w64-mingw32-gcc      -m64
FC        = x86_64-w64-mingw32-gfortran -m64
F90       = x86_64-w64-mingw32-gfortran -m64
RANLIB    = x86_64-w64-mingw32-ranlib
RC        = x86_64-w64-mingw32-windres
export CPP CXX CC FC F90 RANLIB AR RC

debug:
	@echo X64HOME  = $(X64HOME)
	@ls -l /usr/lib/gcc/x86_64-w64-mingw32/4.6/

clean: uninstall
uninstall: 
	rm -rf x64
x64:
	@cd $$HOME/.wine/drive_c/windows                              && \
        rm -f libstdc++-6.dll libgcc_s_sjlj-1.dll                        \
              libgfortran-3.dll libquadmath-0.dll                     && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libstdc++-6.dll     && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libgcc_s_sjlj-1.dll && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libgfortran-3.dll   && \
        ln -s /usr/lib/gcc/x86_64-w64-mingw32/4.6/libquadmath-0.dll   && \
        cd -                                                          && \
        cd $(SRC)/zlib-1.2.8                                          && \
        test -e Makefile && $(MAKE) distclean || true                 && \
        ./configure                                                      \
            --static                                                     \
            --prefix=$(X64HOME) >> $(SRC)/config.log 2>&1             && \
        $(MAKE) install                                               && \
        cd -                                                          && \
        cd -                                                          && \
        PATH=$(SRC)/bin:${PATH}                                          \
        $(MAKE) -C $(SRC)/htslib install                                 \
	       prefix=$(X64HOME)                                         \
	           AR="$(AR)"                                            \
                   CC="$(CC)"                                            \
	       RANLIB="$(RANLIB)"                                        \
            ZLIB_ROOT=$(X64HOME)                                         \
               CFLAGS="-Wall -O2"                                        \
              LDFLAGS="-L$(X64HOME)/lib"                                 \
             PLATFORM="MINGW"                                         && \
	tree $(X64HOME)                                               && \
	file $(X64HOME)/bin/*
