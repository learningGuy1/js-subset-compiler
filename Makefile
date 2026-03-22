all: main
main: lexeur.mll parseur.mly main.ml
	ocamllex lexeur.mll
	ocamlyacc parseur.mly
	ocamlc -c parseur.mli lexeur.ml parseur.ml main.ml
	ocamlc -o main lexeur.cmo parseur.cmo main.cmo
clean:
	rm -f *.cmi *.cmx *.o *.cmo lexeur.ml parseur.mli parseur.ml