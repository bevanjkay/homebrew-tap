cask "zsh-syntax-highlighting" do
  version "0.8.0"
  sha256 "e8c214bf96168f13eaa9d2b78fd3e58070ecf11963b3a626fe5df9dfe0cf2925"

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
