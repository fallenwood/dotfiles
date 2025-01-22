with import <nixpkgs> {};
let

commonpkgs = [
  aria
  bottom
  cmake
  sccache
  # conda
  fzf
  kubectl
  gawk
  # gcc
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
  shellcheck
  tmux
  perl
];

linuxpkgs = [
  proxychains-ng
];

linuxphypkgs = [
  android-tools
  bcc
  bpftrace
  bpftools
  clasp
  # buildah
  # cloud-init
  # (hiPrio clang_17)
  # clang_18
  # clang-tools_18
  cloud-utils
  cloc
  # dub
  # dotnet-sdk_8
  # omnisharp-roslyn
  # dotnet-sdk
  # emacs-nox
  # emscripten
  elixir
  # flamegraph
  # frp
  fish
  htop
  # glibc.static
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
  ruby
  gem
  # shadowsocks-rust
  nerdctl
  # tree-sitter
  # neofetch
  fastfetch
  cpufetch
  ninja
  # mimalloc
  # jemalloc
  podman
  powershell
  postgresql
  # quickjs
  strace
  tailspin
  libvirt
  tig
  # ldc
  # musl-gcc
  # lua
  luajit
  llvm
  wrk
  # nushell
  nmap
  valgrind
  # vagrant
  # rakudo
  # upx
  wasmtime
  # wabt
  # zsh
  # zig
  # zstd
];

macpkgs = [
  vscode
  # alacritty
  # (hiPrio clang)
  lldb
  rustup
  htop
  fish
  # nushell
  # ocaml
  # opam
  powershell
  dotnet-sdk_9
  # dotnet-sdk
  wrk
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

