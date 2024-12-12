$files=@(
  "profile",
  "bashrc",
  "zshrc",
  "env.nix",
  "gitconfig",
  "gitignore_global",
  "xinitrc",
  "Xmodmap")

$dirs=@(
  "config/nvim",
  "config/nvim-full",
  "config/i3",
  "config/i3status",
  # "local/share/fcitx5/rime",
  "config/nushell",
  "config/powershell",
  "config/fish",
  "config/containers")

function Link-Folder {
  param(
    [String] $source,
    [String] $target,
    [String] $backup
  )
  if (Test-Path -Path $backup) {
    Remove-Item -Path $backup -Recurse -Force
  }

  if (Test-Path -Path $target) {
    Rename-Item -Path $target -NewName $backup
  }

  New-Item -Path $target -ItemType SymbolicLink -Value $source
}

foreach ($file in $files) {
  $source = Join-Path $PSScriptRoot "../$file"
  $target = Join-Path $HOME ".$file"
  $backup = Join-Path $HOME ".$file.bak"

  Link-Folder -source $source -target $target -backup $backup
}


foreach ($dir in $dirs) {
  $source = Join-Path $PSScriptRoot "../$dir"
  $target = Join-Path $HOME ".$dir"
  $backup = Join-Path $HOME ".$dir.bak"

  Link-Folder -source $source -target $target -backup $backup
}

