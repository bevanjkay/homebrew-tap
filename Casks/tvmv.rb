cask "tvmv" do
  version "0.5.0"
  sha256 "d395c239e58f1127704271afae4ad8faa0214654c2fb68fbe9da2b2160144761"

  url "https://github.com/keithfancher/tvmv/releases/download/#{version}/tvmv-#{version}-macos.tar.gz"
  name "tvmv"
  desc "TVDB CLI for renaming TV show files"
  homepage "https://github.com/keithfancher/tvmv"

  binary "tvmv-#{version}/tvmv"

  # No zap stanza required
end
