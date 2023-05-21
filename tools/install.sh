set -e

dotfiles=$HOME/.dotfiles
gitrepo=https://github.com/fallenwood/dotfiles.git

if [[ ! -d "$HOME/.dotfiles" ]]; then
    echo "cloning $gitrepo to $dotfiles"
    git clone $gitrepo $dotfiles
else
    echo "$dotfiles exists, skipping"
    # pushd && cd $HOME/.dotfiles && git pull && popd
fi

files=("profile" "bashrc" "zshrc" "env.nix" "gitconfig" "gitignore_global")
# dirs=("SpaceVim.d")
dirs=("config/nvim", "config/i3", "config/i3status)

for file in "${files[@]}"; do
    echo "backing up .$file"
    [[ -s "$HOME/.$file" ]] && mv $HOME/.$file $HOME/.$file.bak
    echo "linking .$file"
    ln -s $dotfiles/$file $HOME/.$file
done

for file in "${dirs[@]}"; do
    echo "backing up .$file"
    [[ -d "$HOME/.$file" ]] && mv $HOME/.$file $HOME/.$file.bak
    [[ -s "$HOME/.$file" ]] && mv $HOME/.$file $HOME/.$file.bak
    echo "linking .$file"
    ln -s $dotfiles/$file $HOME/.$file
done

configs=("powershell/Microsoft.PowerShell_profile.ps1")

for file in "${dirs[@]}"; do
    echo "backing up .$file"
    [[ -d "$HOME/.$file" ]] && mv $HOME/.$file $HOME/.$file.bak
    [[ -s "$HOME/.$file" ]] && mv $HOME/.$file $HOME/.$file.bak
    echo "linking .$file"
    ln -s $dotfiles/$file $HOME/.$file
done
