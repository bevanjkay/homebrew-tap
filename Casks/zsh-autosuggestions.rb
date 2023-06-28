cask "zsh-autosuggestions" do
  version "0.7.0"
  sha256 "ad68b8af2a6df6b75f7f87e652e64148fd9b9cfb95a2e53d6739b76c83dd3b99"

  url "https://github.com/zsh-users/zsh-autosuggestions/archive/refs/tags/v#{version}.zip"
  name "ZSH Autosuggestions Plugin"
  desc "Fish-like autosuggestions for zsh"
  homepage "https://github.com/zsh-users/zsh-autosuggestions"

  suite "zsh-autosuggestions-#{version}", target: "#{Dir.home}/.oh-my-zsh-custom/plugins/zsh-autosuggestions"

  zap rmdir: "#{Dir.home}/.oh-my-zsh-custom"

  caveats do
    "Add the following to your .zshrc file - ZSH_CUSTOM=$HOME/.oh-my.zsh-custom"
  end
end
