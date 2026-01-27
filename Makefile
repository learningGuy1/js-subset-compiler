all:
	ocamlopt -o main.out main.ml
clean:
	rm -f *.cmi *.cmx *.o
