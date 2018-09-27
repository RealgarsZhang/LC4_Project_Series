all:jc

#printnum.o: printnum.c printnum.h lc4libc.h
#	clang -c printnum.c

token.o: token.c token.h
	clang -c token.c

jc: jc.c token.o 
	clang -o  jc jc.c token.o 

clean:
	rm -rf *.o
