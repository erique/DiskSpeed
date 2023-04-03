```
                          DiskSpeed v4.2
                          ScsiSpeed v4.2
                                by
                           Michael Sinz

           Copyright (c) 1989-1992 by MKSoft Development

                       MKSoft Development
                       163 Appledore Drive
                       Downingtown, PA 19335

 Yes, this is yet another disk speed testing program, but with a few
 differences.  It was designed to give the most accurate results of the
 true disk performance in the system.  For this reason many of
 DiskSpeed's results may look either lower or higher than current disk
 performance tests.

******************************************************************************
*                                                                            *
*      Reading legal mush can turn your brain into guacamole!                *
*                                                                            *
*              So here is some of that legal mush:                           *
*                                                                            *
* Permission is hereby granted to distribute this program's source           *
* executable, and documentation for non-commercial purposes, so long as the  *
* copyright notices are not removed from the sources, executable or          *
* documentation.  This program may not be distributed for a profit without   *
* the express written consent of the author Michael Sinz.                    *
*                                                                            *
* This program is not in the public domain.                                  *
*                                                                            *
* Fred Fish is expressly granted permission to distribute this program's     *
* source and executable as part of the "Fred Fish freely redistributable     *
* Amiga software library."                                                   *
*                                                                            *
* Permission is expressly granted for this program and it's source to be     *
* distributed as part of the Amicus Amiga software disks, and the            *
* First Amiga User Group's Hot Mix disks.                                    *
*                                                                            *
******************************************************************************

DiskSpeed 4.2 is a minor update release that also adds ScsiSpeed to the
distribution.  ScsiSpeed is much like DiskSpeed except it does raw device
reading of the device in question.  See end of this file for more details.

------------------------------------------------------------------------------

DiskSpeed 4.1 brings a whole new set of disk drive performance testing
technologies to the game.  These tests, along with smart usage of the
results will give you a very good indication of the performance of
a disk subsystem in the Amiga enviorment.

DiskSpeed 4.1 is now fully configurable and can run from an Icon or
from the CLI.  From the CLI, you have a choice as to if you want the
graphical user interface to the program.

From Workbench, you can start DiskSpeed 4.1 from its tool icon with
the settings within the tooltype of that icon.  You can also start
DiskSpeed from a project icon and it will use the setting from that
icon's tool types.  (Example project icon included)

Two of the options in DiskSpeed 3.1 have been removed for DiskSpeed 4.
CPU Stress testing started out as a good test but ended up becoming
meaningless as the drive manufactures modified the task priorities of
their drives.  However, DiskSpeed 4 went to a much better method:  The
CPU availability index.  This is calculated via a simple task that runs
at a very low priority.  DiskSpeed takes a reading of the system's
performance while idle and uses that reading to determin how much of
the system's CPU is in use during each of the tests.  In addition to
providing better results, it also keeps the CPU in a busy state
and thus could cause a difference in drive performance.

The other feature, DMA stress, has been removed and no direct replacement
is available yet.  The reason there is little that can be done is because
under Release 2 of the operating system the Workbench screen is no longer
a fixed resolution and mode.  This means that using DiskSpeed in different
workbench screen modes will cause a difference in results.  However, it
also means that it will let the user see the performance of the system
with the display mode he uses.  (Most likely)  I am currently investigating
how to implement a safe and reliable DMA stress for a future DiskSpeed.
If something can be found that works in 1.3 I may release a DiskSpeed 4.2
that contains this.  Currently there has been no good way found yet.
(When testing under 2.0 you can switch to the display mode you wish to test
in and try that result.  A 16-colour high-resolution overscanned display
will work out as a good test of custom chip DMA vs the hard drive)

DiskSpeed 4.x will be the last 1.2/1.3 compatible version of DiskSpeed.
As of this point in time, no new DiskSpeed is planned, but if another
version is made, it will require AmigaOS Release 2 as a minimum
operating system version.

The DiskSpeed command line options look much like the standard ReadArgs()
options of Release 2.  They are, however, not the ReadArgs() since that
feature is only available as of Release 2.


These key words are also available from the TOOLTYPES of the icon.

* DRIVE/K	- select drive  (Default is current directory)
	You can use either 'DRIVE <path>'  or  'DRIVE=<path>'

* COMMENT/K	- set comment string
	You can use either 'COMMENT <comment>'  or  'COMMENT=<comment>'

* ALL/S		- select all tests
	This turns on all of the tests below

* DIR/S		- setect DIR tests
* SEEK/S	- select SEEK tests

* CHIP/S	- select CHIP memory buffer tests
* FAST/S	- select FAST memory buffer tests
	You can select both and DiskSpeed will then do a test pass
	with each type of memory.

* LONG/S	- select LONG aligned tests
* WORD/S	- select WORD aligned tests
* BYTE/S	- select BYTE aligned tests
	You can select any combinations of the above.  DiskSpeed
	will do a test pass with each one.  These combine with
	the memory type above to create up to 6 test passes.

* BUF1/K/N	- select buffer size 1	(Default = 512)
* BUF2/K/N	- select buffer size 2	(Default = 4096)
* BUF3/K/N	- select buffer size 3	(Default = 32768)
* BUF4/K/N	- select buffer size 4	(Default = 262144)
	Will let you select the buffer sizes for the tests.
	To eliminate a buffer test, set the buffer to 0.
	You can use either 'BUF1 <num>'  or  'BUF1=<num>'

* WINDOW/S	- use the GUI even though started from the CLI

* MINTIME/K/N	- Selects the number of seconds to run each test. (1 to 500)
  New keyword that lets you select the minimum amount of time any test takes.
  This applies to all tests except for the Directory entry create and delete
  tests.  Also, note that after the file create speed test, a full 256K file
  is created and this can, on slow systems take some time.

* NOCPU/S	- Turns off the CPU available task.
  New keyword that lets you turn off CPU percentage collection.  This is so
  that the secondary task is not created.  Seems that just having this task
  around can be enough to throw the performance of the system way off.  The
  difference in time it takes to task-switch from STOP to the harddisk driver
  and from a background task and the harddisk driver is sometimes just enough
  to cause a rotation on the disk to be missed.  This feature may well be
  removed, but the difference in the numbers is rather interesting.  (The
  background task is at -127 priority...)



Below is a small part of an article I wrote for AmigaWorld Tech Journal
Volume 1, Issue 5.

To get the full article and diagrams, you can contact AmigaWorld
at 1-800-343-0728.  Other back issues are also available.

	Michael Sinz
	MKSoft Development

---------------------------------------------------------------------------

In search of speed...

As the industry moves to even faster drives and even larger data
requirements, high speed drives and drive support will become a
required feature of computers.  Multimedia is one of the application
areas where high performance, large storage devices are required.

The Amiga did not have good hard drive support until the "Fast Filing
System" came out.  However, now that it is here, the performance has
proven that the Amiga is not just a graphics box.  The performance of
the Fast Filing System and the hardware of the Amiga's hard drive
controllers have pushed the limits of data transfer speeds.  With a
good controller, many times the performance is limited by the speed of
the data coming from the drive itself.


Disk Drives:  How fast are they really

500 K-bytes/second.  34 files/second.  This drive.  That controller.
DMA. Non-DMA.  Multitasking friendly.  Video speed.  Millisecond access
times. SCSI.  ST-506.  AT.  IDE.  Adaptec.  OMTI.

The amount of confusing, conflicting, and just plain wrong information
about hard drives is rather extreme.  Maybe the reason for this is
because the Amiga used to have slow hard drives.  Maybe it is because
the Amiga now has some of the fastest hard drives in the industry.
Some of it is also due to a misunderstanding of what the various terms
and numbers mean.  So, what do these numbers mean?  How do they relate
to how fast the system really is? And why are they what they are?

First, what does a disk drive, or more specifically, a hard disk drive
really do?  Yes, we know it stores data, but there must be more
involved in the process.  So, let us first look at some of the basic
technical issues.

Data within a computer is just a series of 1s and 0s. (I know, we all
know that already)  To store this data, the computer must, in some way,
be able to take the 1s and 0s and record them such that they can be
read back as the same pattern of 1s and 0s that were written.  One of
the most popular methods of doing this is magnetic recording.  In much
the same way as audio tape records sounds and plays it back, the
computer generates a signal, or sound, that is recorded and when played
back can be decoded and understood by the computer.  Computers did this
on magnetic tape, magnetic drums, magnetic plated media, spinning
magnetic tape (what became the floppy), and sealed magnetic plated
media.  Through the history of computers, this has been one of the most
complex and fastest advancing fields.  It was not much more than 10
years ago when sealed media hard disk drives (known as Winchesters)
were getting a whopping 5 to 10 million bytes on 8-inch drives. Today,
on small 3.5-inch drives, over 1,000 million bytes are being stored.


Measuring performance

Measuring the performance of a disk subsystem is a rather interesting
science.  In addition to the physical limitations of the drive and
controller, there are issues of software technology at the drive
controller level, the filesystem level, and the operating system level.
In addition, many of the standard testing issues come into play, such
as accuracy of the test, accuracy of the observation, applicability of
the test, etc.

The accuracy of the test can be defined rather exactly.  On the Amiga,
the system has a timer that has a 1/60 second (1/50 in PAL) resolution.
This comes out to roughly 0.02 seconds.  Thus, any given time reading
will be only accurate to within +/- 0.02 seconds.  In order to test the
speed of the tests, the time must be read at the beginning and at the
end of the test. This results in +/- 0.04 seconds of accuracy.  Thus,
in order to make the test have a +/- 1% accuracy, it would have to run
for a minimum of 4 seconds.

The accuracy of the observation is much more difficult to quantify. The
issue here is that in doing the observation, the test, and thus the
results, are affected.  The best that can be done is to try to minimize
the effect of observing the test while not compromising the quality of
the observations.

The last issue:  the applicability of the test.  What this really means
is how well the test (and the results of the test) relates to the
real-use performance of the drive.  This is in many ways more important
that the other two issues as without reasonable applicability, the test
results would be useless.

With DiskSpeed, the disk performance test software that MKSoft
Development has been developing, attention has been paid to make the
tests both accurate and realistic.  DiskSpeed 3.1 has proven itself as
being accurate and has become the standard by which Amiga hard disks
and controllers are judged. With DiskSpeed 4.1 a whole new set of tests
will be possible.


DiskSpeed - The standard in the Amiga world

I had first developed DiskSpeed due to the fact that other disk drive
performance testers were either highly inaccurate or did not relate
well to real-world disk drive usage.  The accuracy issues are easy to
solve, however the applicability issues took some thinking.

The accuracy issues were solved, in DiskSpeed 3.1, by making the tests
take a long time.  This made sure that the clock's accuracy did not
adversely affect the results of the test.  In addition, the tests were
done with as clean of a software design as possible.

With DiskSpeed 4.1, I have developed a new technology that can
automatically size the test time to give as accurate a result as
possible.  It was important that this was only done in the appropriate
tests as some tests radically change their results if they are run for
more iterations.

The more important, and more difficult, part of designing a set of
tests is to come up with ones that will show results that apply to the
real world. In that direction, none of the tests use anything other
than standard AmigaDOS file I/O calls.  Some people ask me to add a
test that does direct device I/O.  However, no application would do
direct device I/O to open/read/write/close/delete a file.  It would not
only be ridiculous, but the amount of work required to write a
filesystem is well beyond what an application developer needs to spend
their time on.

Now that the tests are to only do AmigaDOS I/O, what needs to be
tested?  This is where some knowledge of the physical limitations of
the disk drives and how application software works is needed.

As many of you already know, the Amiga's filing system is very powerful
and flexible.  Much of this power is from the way data is laid out on
the disk.  However, as I am sure you also know, this layout makes some
things a bit slower.  The most noticeable is that of listing a
directory.  Since this is something that causes the system to read many
blocks of data, many from different areas on the disk, and since many
(most) applications and all users run into this performance issue
during every-day use, a test that would measure the performance of the
drive/controller combination when scanning a directory would provide
numbers that directly relate to user experience.

In addition to scanning directories, it is important to be able to
create new directory entries, find directory entries, and delete them.
Again, these are situations that users run into every time they use an
application that does anything with a disk.  All together, these tests
are designed to show the performance of the filesystem's directory
structure.  Note that in order to make these tests fair, the number of
files created in the test directory is always the same.  The speed of
access in a directory structure changes as the number of files change
and if this test were to auto-size itself based on the speed of the
device, the results would no longer be valid.

Another test that help show the performance of the filesystem and
device driver is the Seek/Read test.  This test helps show how well a
database application may run as database operations tend to be very
disk bound and tend to access various locations with a large file. The
Seek/Read test reads small chunks from the file at various locations
within the file.  The speed with which the filesystem can find the
correct data location within the file and then read a part of it is
directly tested by this test.  (Note that the DiskSpeed 3.1 Seek/Read
test was rather simplistic and produced uninteresting numbers.)

The final tests, are the basic file data read and write tests.  There
are three of these:

File Write/Create:  this is where a new file is created and the data is
filled in.  The speed of this is dependant on how fast the filing
system can locate new empty blocks of disk space for the file.

File Write:  this is where an old file is written to.  The performance
here is determined by how well the filing system deals with rewriting
the data in a file that already exists.  This will usually be faster
than the Write/Create test.

File Read:  this is where an old file is read from.  The performance
here is determined by how quickly the filing system finds the data
blocks of a file.

With DiskSpeed 3.1, each of these three tests were done with various
buffer sizes ranging from 512-bytes to 262144-bytes.  DiskSpeed 4.1
adds a few twists to this in that each test will also happen on
LONGWORD aligned buffers, WORD aligned buffers, and BYTE aligned
buffers.  Each test is then done in FAST memory and in CHIP memory (if
you have them available.)  Also new for DiskSpeed 4.1 is the feature
with which you can select the sizes of the tests.

While the larger size buffers are nice to play with, it is important to
remember that most older applications only use a 512-byte buffer. Many
of the newer applications are using 4096-byte buffers as the speed
improvement by just increasing the amount of data read in one I/O call
is rather significant.  DiskSpeed 3.1 helped show this fact.

In addition to the basic tests, DiskSpeed 3.1 let you turn on DMA and
CPU stress factors.  The DMA feature would increase the amount of
bandwidth the video control chips were using.  This was in order to
show how well the drive/controller combination would work in a video
environment.  The CPU stress was an attempt to simulate heavy work
loads in the multi-tasking environment the Amiga provides.

With DiskSpeed 4.1, the CPU stress test has been removed.  It turned
out to produce results that did not mean much.  However, to take its
place is a CPU availability value that is reported for each test. This
is a rough calculation of the available CPU percentage during the test.
This is a very useful number as it will tell you if there is enough CPU
time available to decompress a picture while loading the next one or to
handle user input during disk I/O.

Observing a test always has an impact on the results.  This is a known
fact.  DiskSpeed is no able to get around this fact.  In doing the CPU
availability checking, the performance of the system may change.  This
is due to the fact that just the act of counting the CPU time will
cause some CPU time to be used and will change the dynamics of the
system.  However, if all tests are done the same way, the relative
merits of the drives under test will still be valid.


Why is ... ?

So, now that we have some results, why are they like they are?

Why are small transfers so much slower?
There are a number of reasons.  One of the major ones is the layout of
data on the disk.  The sectors may be lade out on the disk in a number
of ways. When a large transfer happens, it asks for the disk drive to
send the data for a number of blocks.  If these were blocks 1 to 8, the
drive could read all of these blocks in one revolution of the disk.
(given a 1:1 interleave) However, if a program asks for only one block
worth of data at a time, the time between the blocks could be too much
and the next block will have passed by the head of the disk. Then the
disk will have to rotate around until the right block was available
again.  In the example, that would mean that a read of 8 blocks done 1
at a time would take 7 full revolutions once the first block was
transferred.  This makes for a total of 7 times slower than the
transfer that asked for 8 blocks at once.  This is worst case. Many
drives today have some caching and read-ahead that will help minimize
this.

Why are the results inconsistent from one test to another?
Disk performance testing is a rather complex task.  Without special
equipment, many things can not be done.  When DiskSpeed does its tests,
it does not know the exact location of the disk relative to the drive
heads. This means that there will be some difference in timing between
the time the drive is asked to read (or write) a block and the time
that block is under the read/write head.  This time is known as
rotational latency.  The faster the drive spins, the lower this time is.

Why does the CPU test make the drive speed so much slower?
Depending on the method used to implement the controller software, the
CPU test task, which runs at -127 priority, becomes extra overhead.
The difference in speed may be rather small from the CPU standpoint,
but it may be just enough in order to fall pray to the rotational
latency problem.  The overhead difference is that when no task is
running, waking up a task is just starting that task again. If,
however, another task is running at the same time, the old task must
first be put to sleep and this work can be just enough time to make the
system miss the next block that is coming around and would then need to
wait until it comes around again.

Why does drive performance change as the drive gets older?
Drive performance does not really change due to the age of the disk.
However, as files are written to the disk and then later removed, the
empty areas of the disk become scattered.  When the disk is then
tested, the system will have to seek to each of the locations where
part of the data is stored.  This adds seek time, rotational latency,
control overhead, and processor overhead as this information is handled.

Why are write speeds sometimes faster than read?
Well, the way the drive works can have a major impact on this.  If the
drive has a cache, a write could be sent to the cache while the drive
is still waiting for the read/write head to get the position it wanted.
Thus, the disk can say that the write is completed while it is not
quite done.  During the time the system is getting ready for the next
write, the drive will hopefully have sent the last write to the disk.

What number is most important?
This is a hard question.  It would depend on your application and how
you use your machine.  If you many times do directory listings or
create files, it would be best to look at the directory manipulation
tests; these include Files-per-second create/open/scan/delete.  One of
the numbers that is most important to me is the small buffer
performance.  That is, the performance of the drive/controller on
buffered reads between the sizes of 512 bytes to 4096 bytes)  These two
buffer sizes are much more representative of the size of the read/write
buffers of most applications.  While the large buffer sizes are
important to graphics and animation persons where high speed
performance to large files is a major factor.  However, this is only
useful if the file can be read as one big chunk.

Why does the test sometimes show more that 100% available CPU?
Due to the fact that the CPU availability had to be measured to get a
reading of how much total CPU there was, the measurement could have
been a small amount incorrect.  The measurement code tries its best to
get an accurate measurement but this is not always possible.  It will
notice (most of the time) when accurate measurements are not possible
and turn off the CPU testing since it would be meaningless.


With the addition of the CPU availability numbers, a much more complete
picture of drive and system performance can be obtained.  As multimedia
becomes more important, the performance combination of high drive speed
along with large amounts of available CPU power will be what makes it
all possible.

With DiskSpeed 4.1, it will be possible for developers to make sure
that the design of their hardware/software lives up to the performance
needs of their users.  It will also give the data that proves the
performance of the system for real work.  Applications such as database
servers, file servers, and multimedia require as much performance as
possible in the drive subsystem. The Amiga has the performance to
outshine most other platforms in this area.

******************************************************************************
******************************************************************************
******************************************************************************
				ScsiSpeed 4.2

ScsiSpeed was written due to the demand for more details on the raw
performance of the drives connected to the system.  What ScsiSpeed does is
use low-level device I/O to read the disk starting at block 0 and working up.
ScsiSpeed, with a reasonable test time such as 20 seconds, will show the
true sustained performance of the drive/interface combination without the
overhead of the filesystem and AmigaDOS.

Basically, the usage of ScsiSpeed is the same as DiskSpeed except for options
which do not apply.  (Such as DIR and SEEK tests, etc)

Also, the device/drive specification is different.  You must give the device
name (such as scsi.device or trackdisk.device) and the unit number as follows:

scsi.device:6		<- This would be unit 6 of scsi.device (default)
trackdisk.device:0	<- This would be DF0:

Note that due to some controller limitations, only long-aligned read tests
are done.  Also, ScsiSpeed does not write to the disk and thus will not
destroy any data on the disk.  This also means that it can test devices
such as CD-ROM and WORM disks.
```
