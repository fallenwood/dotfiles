{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  # nativeBuildInputs = [ pkgs.buildPackages.ruby_2_3 ];

  buildInputs = [
    pkgs.neovim
    pkgs.ripgrep
    pkgs.go_1_18
    pkgs.dotnet-sdk
    pkgs.jdk17_headless
    pkgs.clang_14
  ];

  shellHook = ''
  '';
}
