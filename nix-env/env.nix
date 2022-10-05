# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

mypkgs = [
    aria
    (hiPrio clang_14)
    cmake
    dotnet-sdk
    jdk17_headless
    kubectl
    gcc12
    # graphviz
    gdb
    git
    go_1_18
    lldb_14
    neovim
    proxychains-ng
    ripgrep
    tmux
    tig
    # valgrind
];

mylibs = [
    liburing
];

in [ nix ] ++ mypkgs ++ mylibs
