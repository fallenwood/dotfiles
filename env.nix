# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
  aria
  (hiPrio clang_14)
  clang-tools_14
  cmake
  # conda
  jdk17_headless
  kubectl
  gawk
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
  # flamegraph
  # frp
  htop
  # lm_sensors
  rustup
  # shadowsocks-rust
  ninja
  podman
  powershell
  # quickjs
  # elixir
  neofetch
  libvirt
  tig
  luajit
  llvm
  wrk
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
  # liburing
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

