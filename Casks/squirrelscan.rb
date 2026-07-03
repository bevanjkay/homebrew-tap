cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.63"
  sha256 arm:          "f8af6525b089742fcff02a7485cd897f5c34e408c17898cd0f32112ebe872587",
         intel:        "474b907898a5e68d371e0f905fd710832454d4f9d50ec8e5b9fc6c5a7d72ee56",
         x86_64_linux: "98290e63647f918655cb1fb952d1ee7f24ff4b3a8a44aec9abf6fc9bac5fc5df",
         arm64_linux:  "2dccc6c8d3fe226df1f9179232ba00db2be2d8adf802fad6e1abf95f461b3610"

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
