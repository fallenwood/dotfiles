import * as std from "std";
import * as os from "os";

const dotfiles=`${std.getenv("HOME")}/.dotfiles`
const gitrepo="https://github.com/fallenwood/dotfiles.git";

function setupDotfiles() {
  const [info, err] = os.stat(dotfiles);

  if (err !== 0 || info.mode & os.S_IFDIR === os.S_IFDIR) {
    console.log("Cloning $gitrepo to $dotfiles");
    std.exec(`git clone ${gitrepo} ${dotfiles}`);
  } else {
    console.log(`${dotfiles} exists, skipping`);
  }
}

function makeBackup(origin, backup) {
  const [_, err] = os.stat(origin);
  if (err === 0) {
    os.rename(origin, backup);
  }
}

function makeLink(target, link) {
  os.symlink(target, link);
}

function setupFiles() {
  const files = ["profile", "bashrc", "zshrc", "env.nix", "gitconfig", "gitignore_global"];

  for (const file of files) {
    console.log(`Backing up ${file}`);
    makeBackup(`${HOME}/.${file}`, `${HOME}/.${file}.bak`);

    console.log(`Linking ${file}`);
    makeLink(`${dotfiles}/${file}`, `${HOME}/.${file}`);
  }
}

function setupDirectories() {

}

function main() {
  setupDotfiles();
  setupFiles();
}

main();
