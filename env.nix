# { pkgs ? import <nixpkgs> {} }:
with import <nixpkgs> {};
let

commonpkgs = [
  aria
  bottom
  (hiPrio clang_17)
  clang-tools_17
  cmake
  # conda
  fzf
  kubectl
  gawk
  gcc
  # gcc12
  # graphviz
  gdb
  git
  gnumake
  go
  jq
  lldb_14
  neovim
  ripgrep
  skim
  tailspin
  tmux
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
  cloc
  dub
  dotnet-sdk_8
  dotnet-sdk
  emacs-nox
  emscripten
  # elixir
  # flamegraph
  # frp
  htop
  jdk21_headless
  kind
  kubernetes-helm
  # koka
  lm_sensors
  leiningen
  libbpf
  rustup
  # ruby
  # gem
  # shadowsocks-rust
  # nerdctl
  # tree-sitter
  neofetch
  ninja
  mimalloc
  podman
  powershell
  # quickjs
  strace
  libvirt
  tig
  ldc
  # lua
  luajit
  llvm
  wrk
  # nushell
  nmap
  # vagrant
  # rakudo
  upx
  # wasmtime
  wabt
  zsh
  # zig
  # zstd
];

macpkgs = [
  vscode
  # alacritty
  rustup
  htop
  nushell
  # ocaml
  # opam
];

linuxlibs = [
  # liburing
];

linuxphylibs = [
  zlib
  openssl
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

