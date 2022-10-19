# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

mypkgs = [
    aria
    (hiPrio clang_14)
    clang-tools_14
    cmake
    dotnet-sdk
    # emacs-nox
    jdk17_headless
    kubectl
    # gcc12
    # graphviz
    gdb
    git
    go_1_18
    lldb_14
    luajit
    neovim
    rakudo
    proxychains-ng
    ripgrep
    tmux
    tig
    # valgrind
    zsh
];

mylibs = [
    liburing
];

in [ nix ] ++ mypkgs ++ mylibs
