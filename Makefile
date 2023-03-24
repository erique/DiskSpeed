#
#                          DiskSpeed v4.2
#                          ScsiSpeed v4.2
#                                by
#                           Michael Sinz
#
#             Copyright (c) 1989-1992 by MKSoft Development
#
#                       MKSoft Development
#                       163 Appledore Drive
#                       Downingtown, PA 19335
#
# Yes, this is yet another disk speed testing program, but with a few
# differences.  It was designed to give the most accurate results of the
# true disk performance in the system.  For this reason many of
# DiskSpeed's results may look either lower or higher than current disk
# performance tests.
#
##############################################################################
#                                                                            #
#       Reading legal mush can turn your brain into guacamole!               #
#                                                                            #
#               So here is some of that legal mush:                          #
#                                                                            #
# Permission is hereby granted to distribute this program's source           #
# executable, and documentation for non-commercial purposes, so long as the  #
# copyright notices are not removed from the sources, executable or          #
# documentation.  This program may not be distributed for a profit without   #
# the express written consent of the author Michael Sinz.                    #
#                                                                            #
# This program is not in the public domain.                                  #
#                                                                            #
# Fred Fish is expressly granted permission to distribute this program's     #
# source and executable as part of the "Fred Fish freely redistributable     #
# Amiga software library."                                                   #
#                                                                            #
# Permission is expressly granted for this program and it's source to be     #
# distributed as part of the Amicus Amiga software disks, and the            #
# First Amiga User Group's Hot Mix disks.                                    #
#                                                                            #
##############################################################################
#
# MakeFile for DiskSpeed and ScsiSpeed
#

# export VBCC=/opt/amiga
# export PATH=$PATH:$VBCC/bin

AS=vasmm68k_mot
CC=m68k-amigaos-gcc
STRIP=m68k-amigaos-strip

%.o : %.asm
	$(AS) $(ASFLAGS) -o $@ $<

CFLAGS= -noixemul -g -Os -Wno-int-conversion -Wno-incompatible-pointer-types
LDFLAGS=-noixemul -nodefaultlibs -lamiga -lnix -lnix20 -lnixmain -lstubs
ASFLAGS=-Fhunk -quiet -no-opt -warncomm -wfail -x -I$(VBCC)/m68k-amigaos/ndk-include

OBJS=	DiskSpeedCPU.o RenderInfo.o MakeBoxes.o MKS_List.o

LIBS=

ALL:	DiskSpeed ScsiSpeed

DiskSpeed: DiskSpeed.ld
	$(STRIP) -o $@ $<

DiskSpeed.ld: DiskSpeed.o $(OBJS) $(LIBS)
	$(CC) -o $@ $^ $(LDFLAGS)

ScsiSpeed: ScsiSpeed.ld
	$(STRIP) -o $@ $<

ScsiSpeed.ld: ScsiSpeed.o $(OBJS) $(LIBS)
	$(CC) -o $@ $^ $(LDFLAGS) 

DiskSpeed.o:	DiskSpeed.c DiskSpeed_rev.h
ScsiSpeed.o:	ScsiSpeed.c DiskSpeed.c ScsiSpeed_rev.h

version:
	BumpRev 4 DiskSpeed_rev
	BumpRev 4 ScsiSpeed_rev
