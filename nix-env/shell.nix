{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  # nativeBuildInputs = [ pkgs.buildPackages.ruby_2_3 ];

  buildInputs = [
    pkgs.aria
    pkgs.clang_14
    pkgs.cmake
    pkgs.dotnet-sdk
    pkgs.jdk17_headless
    pkgs.kubectl
    pkgs.gdb
    pkgs.git
    pkgs.go_1_18
    pkgs.lldb_14
    pkgs.neovim
    pkgs.proxychains-ng
    pkgs.ripgrep
    pkgs.tig
  ];

  shellHook = ''
    echo "Starting default nix environment..."
  '';
}
