# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
    aria
    (hiPrio clang_14)
    clang-tools_14
    cmake
    # conda
    # dotnet-sdk
    # dotnet-sdk_7
    jdk17_headless
    kubectl
    gcc
    # gcc12
    # graphviz
    gdb
    git
    gnumake
    go
    lldb_14
    neovim
    ripgrep
    tmux
    telnet
    # valgrind
];

linuxpkgs = [
    proxychains-ng
];


linuxphypkgs = [
    bcc
    bpftrace
    bpftools
    # buildah
    # cloud-init
    cloud-utils
    dotnet-sdk_7
    #dotnet-sdk
    emacs-nox
    # frp
    htop
    # lm_sensors
    rustup
    # shadowsocks-rust
    ninja
    powershell
    # quickjs
    # elixir
    neofetch
    libvirt
    tig
    luajit
    # nushell
    # vagrant
    # rakudo
    zsh
];

macpkgs = [
    vscode
    alacritty
    rustup
    ocaml
    opam
];

linuxlibs = [
    liburing
];

linuxphylibs = [
    # zlib
];

isWsl = builtins.getEnv "isWsl";

services.libvirtd.enable = true;
virtualisation.libvirtd.enable = true;

in 
if stdenv.isLinux then
    if isWsl=="" then
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs
    else
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs ++ linuxphypkgs ++ linuxphylibs
else
    [ nix ] ++ commonpkgs ++ macpkgs

