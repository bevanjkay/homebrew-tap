cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.50"
  sha256 arm:          "cec28038d22a187677bb8f8d6c6fe19f38543ebaa70089fc9a3f80ae90c4669b",
         intel:        "5d1baedfd58eb39789104a16079fcb011f023e508aa20567a68497eaef83d3dc",
         x86_64_linux: "e39d0cb8e86306c0d81e0366ab0d2d8b9f4a437e37af09a065021fd5e2541968",
         arm64_linux:  "52d336ee2eaa92863e06332daac91564fa5aec4cb858d531f9058a49d890bae6"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}",
      verified: "github.com/squirrelscan/squirrelscan/"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/squirrel-#{version}-darwin-#{arch}" if OS.mac?
  end

  zap trash: "~/.squirrel"
end
