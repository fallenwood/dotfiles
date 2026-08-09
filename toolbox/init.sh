sudo mkdir -p /home/linuxbrew/
sudo ln -s $HOME/.local/share/zerobrew/prefix /home/linuxbrew/.linuxbrew
sudo dnf update -y \
  && sudo dnf install \
     gcc clang cmake sccache lldb \ # C++ / rust
     gtk4-devel \ # ghostty
     gtk4-layer-shell-devel \
     libadwaita-devel \
     gettext \
     blueprint-compiler
