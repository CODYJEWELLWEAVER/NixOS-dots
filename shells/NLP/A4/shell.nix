{ pkgs ? import <nixpkgs> {}, config ? {} }:
let
  pythonPackages = pkgs.python3.withPackages (
    py: [
      py.numpy
      py.torch
      py.tqdm
      py.spacy
      py.nltk
      py.torchvision
      py.transformers
      py.sentencepiece
      py.protobuf
      py.rouge-score
    ]
  );
in pkgs.mkShell {
  name = "assignment4";
  buildInputs = [
    (pythonPackages)
  ];
}
