# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
    aria
    (hiPrio clang_14)
    clang-tools_14
    cmake
    dotnet-sdk
    # emacs-nox
    jdk17_headless
    kubectl
    gcc
    # gcc12
    # graphviz
    gdb
    git
    gnumake
    go_1_18
    lldb_14
    luajit
    neovim
    rakudo
    ripgrep
    tmux
    tig
    # valgrind
    zsh
];

linuxpkgs = [
    proxychains-ng
];

macpkgs = [
    vscode
];

mylinuxlibs = [
    liburing
];

in 
if stdenv.isLinux then
    [ nix ] ++ commonpkgs ++ linuxpkgs ++ mylinuxlibs
else
    [ nix ] ++ commonpkgs ++ macpkgs
