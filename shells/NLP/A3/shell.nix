{ pkgs ? import <nixpkgs> {}, config ? {} }:
let
  pythonPackages = pkgs.python3.withPackages (
    py: [
      py.numpy
      py.torch
      py.scipy
      py.torchvision
      py.matplotlib
    ]
  );
in pkgs.mkShell {
  name = "assignment3";
  buildInputs = [
    (pythonPackages)
  ];
}
