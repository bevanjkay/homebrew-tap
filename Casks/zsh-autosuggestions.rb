cask "zsh-autosuggestions" do
  version "0.7.0"
  sha256 "ccd97fe9d7250b634683c651ef8a2fe3513ea917d1b491e8696a2a352b714f08"

  url "https://github.com/zsh-users/zsh-autosuggestions/archive/refs/tags/v#{version}.tar.gz"
  name "ZSH Autosuggestions Plugin"
  desc "Fish-like autosuggestions for zsh"
  homepage "https://github.com/zsh-users/zsh-autosuggestions"

  suite "zsh-autosuggestions-#{version}", target: "#{Dir.home}/.oh-my-zsh-custom/plugins/zsh-autosuggestions"

  zap rmdir: "#{Dir.home}/.oh-my-zsh-custom"

  caveats do
    "Add the following to your .zshrc file - ZSH_CUSTOM=$HOME/.oh-my.zsh-custom"
  end
end
