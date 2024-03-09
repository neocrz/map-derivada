{ pkgs ? import <nixpkgs> { }, ...}:

pkgs.mkShell {
  nativeBuildInputs = [
  ];

  buildInputs = with pkgs; [
    julia-bin
    python3
  ];

  shellHook = ''
    # ...
  '';
}
