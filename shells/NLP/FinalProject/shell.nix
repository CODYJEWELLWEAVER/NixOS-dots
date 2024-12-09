{ pkgs ? import <nixpkgs> {}, config ? {} }:
let
 pythonPackages = pkgs.python3.withPackages (
    ps: [ 
      ps.torchWithCuda
      ps.accelerate
      ps.datasets
      ps.transformers
      ps.tqdm
      ps.evaluate
      ps.nltk
    ]
  );
in
pkgs.mkShell {
 name = "torch";
 buildInputs = [
   (pythonPackages)
 ];
 shellHook = ''
   export PYTHONPATH="${pythonPackages}:${PYTHONPATH:-}"
 '';
}
