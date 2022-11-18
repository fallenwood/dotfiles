# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
    aria
    (hiPrio clang_14)
    clang-tools_14
    cmake
    dotnet-sdk
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
    perl
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


linuxphypkgs = [
    bpftrace
    bpftools
    cargo
    emacs-nox
    frp
    htop
    lm_sensors
    podman
    rustc
    shadowsocks-rust
    qemu_full
]; 

macpkgs = [
    vscode
    alacritty
    rustup
    ocaml
    opam
];

linuxlibs = [
    # liburing
];

isWsl = builtins.getEnv "isWsl";

in 
if stdenv.isLinux then
    if isWsl=="" then
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs
    else
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs ++ linuxphypkgs
else
    [ nix ] ++ commonpkgs ++ macpkgs

