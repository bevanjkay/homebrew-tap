cask "zsh-syntax-highlighting-static" do
  version "0.8.0"
  sha256 "5981c19ebaab027e356fe1ee5284f7a021b89d4405cc53dc84b476c3aee9cc32"

  url "https://github.com/zsh-users/zsh-syntax-highlighting/archive/refs/tags/#{version}.tar.gz"
  name "ZSH Syntax Highlighting Plugin"
  desc "Fish-like syntax highlighting for zsh"
  homepage "https://github.com/zsh-users/zsh-syntax-highlighting"

  suite "zsh-syntax-highlighting-#{version}", target: "#{Dir.home}/.oh-my-zsh-custom/plugins/zsh-syntax-highlighting"

  zap rmdir: "#{Dir.home}/.oh-my-zsh-custom"

  caveats do
    "Add the following to your .zshrc file - ZSH_CUSTOM=$HOME/.oh-my.zsh-custom"
  end
end
