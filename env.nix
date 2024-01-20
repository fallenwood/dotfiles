with import <nixpkgs> {};
let

commonpkgs = [
  aria
  bottom
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
  neovim
  ripgrep
  skim
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
  (hiPrio clang_17)
  clang-tools_17
  cloud-utils
  cloc
  # dub
  dotnet-sdk_8
  # dotnet-sdk
  emacs-nox
  # emscripten
  # elixir
  # flamegraph
  # frp
  # fish
  htop
  glibc.static
  jdk21_headless
  kind
  kubernetes-helm
  # koka
  lm_sensors
  lldb_17
  # leiningen
  libbpf
  mold
  rustup
  # ruby
  # gem
  # shadowsocks-rust
  # nerdctl
  # tree-sitter
  neofetch
  ninja
  # mimalloc
  podman
  powershell
  # quickjs
  strace
  tailspin
  libvirt
  tig
  # ldc
  # musl
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
  # wabt
  # zsh
  # zig
  # zstd
];

macpkgs = [
  vscode
  # alacritty
  (hiPrio clang)
  lldb
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

