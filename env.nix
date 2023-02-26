# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
    aria
    (hiPrio clang_14)
    clang-tools_14
    cmake
    dotnet-sdk
    dotnet-sdk_7
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
    neovim
    ripgrep
    tmux
    # valgrind
];

linuxpkgs = [
    proxychains-ng
];


linuxphypkgs = [
    # bpftrace
    # bpftools
    # emacs-nox
    # frp
    htop
    # lm_sensors
    rustup
    # shadowsocks-rust
    # ninja
    powershell
    # quickjs
    elixir
    neofetch
    libvirt
    tig
    luajit
    rakudo
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

linuxphylibs = [
    # zlib
];

isWsl = builtins.getEnv "isWsl";

in 
if stdenv.isLinux then
    if isWsl=="" then
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs
    else
      [ nix ] ++ commonpkgs ++ linuxpkgs ++ linuxlibs ++ linuxphypkgs ++ linuxphylibs
else
    [ nix ] ++ commonpkgs ++ macpkgs

