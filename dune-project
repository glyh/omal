(lang dune 3.15)

(name omal)

(using menhir 2.0)

(generate_opam_files true)

(source
 (github glyh/omal))

(authors "Yihang Liu")

(maintainers "Yihang Liu")

(license GPL-3.0-or-later)

(documentation https://github.com/glyh/omal)

(package
 (name omal)
 (synopsis "Mal implemented in OCaml")
 (description "Mal implemented in OCaml")
 (depends
   ocaml
   dune
   menhir
   (linenoise (>= 1.5.1))
   (nice_parser (= 1.0.0)))
 (tags
  (topics mal)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
