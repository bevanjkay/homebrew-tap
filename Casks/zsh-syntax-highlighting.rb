cask "zsh-syntax-highlighting" do
  version "0.7.1"
  sha256 "69f117a988acd97f5399bfda92f837052164c4837d73d0888cc1ccc6117a34c6"

  url "https://github.com/zsh-users/zsh-syntax-highlighting/archive/refs/tags/#{version}.zip"
  name "ZSH Syntax Highlighting Plugin"
  desc "Fish-like syntax highlighting for zsh"
  homepage "https://github.com/zsh-users/zsh-syntax-highlighting"

  suite "zsh-syntax-highlighting-#{version}", target: "#{Dir.home}/.oh-my-zsh-custom/plugins/zsh-syntax-highlighting"

  zap rmdir: "#{Dir.home}/.oh-my-zsh-custom"

  caveats do
    "Add the following to your .zshrc file - ZSH_CUSTOM=$HOME/.oh-my.zsh-custom"
  end
end
