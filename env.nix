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
    # gcc12
    # graphviz
    gdb
    git
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
]

mylibs = [
    liburing
];

in 
if stdenv.isLinux then
    [ nix ] ++ commonpkgs ++ linuxpkgs ++ mylibs
else
    [ nix ] ++ commonpkgs ++ macpkgs ++ mylibs