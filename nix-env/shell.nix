{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.aria
    pkgs.clang_14
    pkgs.cmake
    pkgs.dotnet-sdk
    pkgs.jdk17_headless
    pkgs.kubectl
    pkgs.gcc12
    # pkgs.graphviz
    pkgs.gdb
    pkgs.git
    pkgs.go_1_18
    pkgs.lldb_14
    pkgs.neovim
    pkgs.proxychains-ng
    pkgs.ripgrep
    pkgs.tmux
    pkgs.tig
    # pkgs.valgrind
  ];

  shellHook = ''
    echo "Starting default nix environment..."
  '';
}
