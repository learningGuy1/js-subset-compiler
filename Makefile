all: main
main: lexeur.mll parseur.mly main.ml
	ocamllex lexeur.mll
	ocamlyacc parseur.mly
	ocamlc -c AST.ml parseur.mli lexeur.ml parseur.ml main.ml
	ocamlc -o main AST.cmo lexeur.cmo parseur.cmo main.cmo
clean:
	rm -f *.cmi *.cmx *.o *.cmo lexeur.ml parseur.mli parseur.ml main
