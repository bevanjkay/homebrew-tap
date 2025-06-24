cask "zsh-autosuggestions-static" do
  version "0.7.1"
  sha256 "0df7affff21cd87ed298e6a3970ed08a1dd66a6efa676454ee5b091ad503badf"

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
