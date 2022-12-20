PDAY = $(shell printf '%02d' $(DAY))

all: build run

build:
	g++ -O2 Day$(PDAY).cpp -o Day$(PDAY).exe
	
run:
	./Day$(PDAY).exe < ../inputs/$(DAY).txt

clean:
	rm -f Day*.exe