all: trace

lc4.o: lc4.c lc4.h
	clang -c lc4.c

objectfiles.o: objectfiles.c objectfiles.h lc4.c
	clang -c objectfiles.c

#lc4:
	# TODO: Impelemnt

#objectfiles:
	# TODO: implement

trace: trace.c lc4.o objectfiles.o
	clang -o trace trace.c lc4.o objectfiles.o
	# TODO: Implement

#
# THIS IS FOR GRADING. DO NOT MODIFY THIS TARGET.
#
testlc4: testlc4.c lc4
	clang -g -o testlc4 lc4.o

#
# Add more if necessary.
#
clean:
	rm -f *.o
	rm -f trace
