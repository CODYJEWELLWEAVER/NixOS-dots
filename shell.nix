{ pkgs ? import <nixpkgs> {}, config ? {} }:
let 
  pythonPackages = pkgs.python3.withPackages (
    py: [
      py.numpy
      py.spacy
      py.nltk
    ]
  );
in
pkgs.mkShell {
  name = "assignment1";
  buildInputs = [
    (pythonPackages)
  ];
  shellHook = ''
    export PYTHONPATH="${pythonPackages}:${PYTHONPATH:-}"
  '';
}