{ pkgs ? import <nixpkgs> {}, config ? {}}:
let
  pythonPackages = pkgs.python3.withPackages(
    py: [
      py.numpy
      py.spacy
      py.torch
      py.scipy
      py.nltk
      py.matplotlib
      py.torchvision
    ]
  );
in pkgs.mkShell {
  name = "assignment2";
  buildInputs = [
    (pythonPackages)
  ];
  shellHook = ''
    export PYTHONPATH="${pythonPackages}:${PYTHONPATH:-}"
  '';
}
