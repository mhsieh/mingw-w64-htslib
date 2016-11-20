# THIS IS THE MAKEFILE FOR CROSS-COMPILING HTSLIB FOR MINGW32/MINGW-W64 UNDER
# TRAVIS CI ENVIRONMENT
# AUTHOR: Mengjuei Hsieh
SRC      := $(shell pwd)
X64HOME  := $(SRC)/x64
I386HOME := $(SRC)/i386

debug:
	@echo X64HOME  = $(X64HOME)
	@echo I386HOME = $(I386HOME)
	@ls -l /usr/lib/gcc/i686-w64-mingw32/4.6/
	@ls -l /usr/lib/gcc/x86_64-w64-mingw32/4.6/

clean: uninstall
uninstall: 
	rm -rf x64 i386
